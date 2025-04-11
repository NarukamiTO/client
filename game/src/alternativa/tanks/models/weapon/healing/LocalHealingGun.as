package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.models.weapon.healing.targeting.IsisDirectionCalculator;
  import alternativa.tanks.models.weapon.healing.targeting.IsisTargetPriorityCalculator;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class LocalHealingGun extends BattleRunnerProvider implements Weapon, LocalWeapon, HealingGun, LogicUnit {
    private static const MINIMAL_UPDATE_HIT_TIME_MS:int = 250;
    private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
    private static const localHitPoint:Vector3 = new Vector3();
    private static const bonusDirection:Vector3 = new Vector3();
    private static const rotationMatrix:Matrix3 = new Matrix3();

    private var controller:SimpleWeaponController;
    private var weaponPlatform:WeaponPlatform;
    private var callback:HealingGunCallback;
    private var effects:HealingGunEffects;
    private var targetingSystem:TargetingSystem;
    private var isisCC:IsisCC;
    private var shooting:Boolean;
    private var triggerPulled:Boolean;
    private var enabled:Boolean;
    private var baseTime:int;
    private var state:IsisState;
    private var nextTickTime:EncryptedInt = new EncryptedIntImpl();
    private var numTicksLeft:EncryptedInt = new EncryptedIntImpl();
    private var currentTarget:Body;
    private var currentRayHit:RayHit;
    private var updateHitTime:int;
    private var isisTargetPriorityCalculator:IsisTargetPriorityCalculator;
    private var isisDirectionCalculator:IsisDirectionCalculator;
    private var singleTargetDirectionProcessor:SingleTargetDirectionProcessor;
    private var stunStatus:Number;
    private var stunned:Boolean;

    public function LocalHealingGun(param1:IGameObject, param2:IsisCC, param3:SimpleWeaponController, param4:HealingGunEffects, param5:HealingGunCallback) {
      super();
      this.isisTargetPriorityCalculator = new IsisTargetPriorityCalculator(param2);
      this.isisDirectionCalculator = new IsisDirectionCalculator(param2.coneAngle);
      this.singleTargetDirectionProcessor = new SingleTargetDirectionProcessor(param1,param2.radius);
      this.targetingSystem = new TargetingSystem(this.isisDirectionCalculator,this.singleTargetDirectionProcessor,new TargetingPriorityCalculator(this.isisTargetPriorityCalculator));
      this.targetingSystem.getProcessor().setShotFromMuzzle();
      this.controller = param3;
      this.callback = param5;
      this.effects = param4;
      this.isisCC = param2;
    }

    private static function getEffectType(param1:Tank, param2:Tank) : IsisState {
      return param1.isSameTeam(param2.teamType) ? IsisState.HEALING : IsisState.DAMAGING;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.effects.init(param1.getTurret3D(),param1.getLocalMuzzlePosition());
      this.controller.init();
      this.controller.setWeapon(this);
    }

    public function destroy() : void {
      this.targetingSystem = null;
      this.effects = null;
      this.callback = null;
      this.deactivate();
      this.controller.destroy();
    }

    public function activate() : void {
      getBattleRunner().addLogicUnit(this);
    }

    public function deactivate() : void {
      this.disable(false);
      getBattleRunner().removeLogicUnit(this);
    }

    public function enable() : void {
      if(!this.enabled) {
        this.enabled = true;
        this.triggerPulled = this.controller.isTriggerPulled();
      }
    }

    public function disable(param1:Boolean) : void {
      if(this.enabled) {
        this.enabled = false;
        this.stop(getBattleRunner().getPhysicsTime(),param1);
      }
    }

    public function reset() : void {
      this.isisTargetPriorityCalculator.resetTarget();
      this.currentTarget = null;
      this.shooting = false;
      this.triggerPulled = false;
      this.baseTime = 0;
      this.numTicksLeft.setInt(0);
      this.nextTickTime.setInt(0);
      this.state = IsisState.OFF;
    }

    public function getStatus() : Number {
      var local1:Number = NaN;
      if(this.stunned) {
        return this.stunStatus;
      }
      if(this.shooting) {
        local1 = this.getCurrentEnergyInShootingMode(getTimer(),this.state);
      } else {
        local1 = this.getCurrentEnergyInIdleMode(getTimer());
      }
      return local1 / this.isisCC.capacity;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.enabled) {
        if(this.shooting) {
          this.runLogicForShootingMode(param1);
        } else {
          this.runLogicForIdleMode(param1);
        }
      }
    }

    private function runLogicForShootingMode(param1:int) : void {
      var local2:Body = null;
      if(this.triggerPulled) {
        this.weaponPlatform.getAllGunParams(allGunParams);
        if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams)) {
          this.currentRayHit = this.target();
          local2 = Boolean(this.currentRayHit) ? this.currentRayHit.shape.body : null;
        } else {
          this.currentRayHit = null;
          local2 = null;
        }
        if(local2 != this.currentTarget) {
          this.currentTarget = local2;
          this.changeTargetAndNotifyCallback(param1);
        } else if(this.currentTarget != null) {
          if(this.updateHitTime + MINIMAL_UPDATE_HIT_TIME_MS <= param1) {
            this.updateHit(param1);
          }
          this.setupEffectsForTarget();
        }
        this.tryToTick(param1);
        this.tryToStop(param1);
      } else {
        this.stop(param1,true);
      }
    }

    private function tryToStop(param1:int) : void {
      if(this.numTicksLeft.getInt() == 0 && this.getCurrentEnergyInShootingMode(param1,this.state) <= 0) {
        this.stop(param1,true);
      }
    }

    private function tryToTick(param1:int) : void {
      if(this.numTicksLeft.getInt() > 0) {
        if(param1 >= this.nextTickTime.getInt()) {
          this.numTicksLeft.setInt(this.numTicksLeft.getInt() - 1);
          this.tick(param1);
        }
      }
    }

    private function tryToResumeShooting() : void {
      if(!this.triggerPulled && this.controller.isTriggerPulled()) {
        this.pullTrigger();
      }
    }

    private function runLogicForIdleMode(param1:int) : void {
      if(this.triggerPulled) {
        this.start(param1);
      }
    }

    public function pullTrigger() : void {
      if(this.enabled) {
        this.triggerPulled = true;
      }
    }

    public function releaseTrigger() : void {
      this.triggerPulled = false;
    }

    public function onTargetLost(param1:Tank) : void {
      if(param1 != null) {
        if(this.currentTarget == param1.getBody()) {
          this.currentTarget = null;
          this.changeTarget(getBattleRunner().getPhysicsTime());
        }
      }
    }

    private function changeTargetAndNotifyCallback(param1:int) : void {
      this.changeTarget(param1);
      this.updateHit(param1);
    }

    private function updateHit(param1:int) : void {
      this.updateHitTime = param1;
      this.callback.updateHit(param1,this.currentRayHit);
    }

    private function changeTarget(param1:int) : void {
      var local3:Tank = null;
      var local2:IsisState = this.state;
      if(this.currentTarget == null) {
        this.state = IsisState.IDLE;
      } else {
        local3 = this.weaponPlatform.getBody().tank;
        if(getEffectType(local3,this.currentTarget.tank) == IsisState.HEALING) {
          this.state = IsisState.HEALING;
        } else {
          this.state = IsisState.DAMAGING;
        }
      }
      this.baseTime = this.getBaseTimeInShootingMode(param1,this.getCurrentEnergyInShootingMode(param1,local2),this.state);
      if(this.currentTarget == null) {
        this.loseTarget();
      } else {
        this.onNewTarget(param1);
      }
    }

    private function loseTarget() : void {
      this.effects.setLocalEffectsType(IsisState.IDLE);
      this.isisTargetPriorityCalculator.resetTarget();
      this.numTicksLeft.setInt(0);
    }

    private function onNewTarget(param1:int) : void {
      this.calculateNumTicks(param1);
      this.setNextTickTime(param1);
      this.setupEffectsForTarget();
    }

    private function setupEffectsForTarget() : void {
      var local1:Tank = this.currentTarget.tank;
      var local2:Tank = this.weaponPlatform.getBody().tank;
      localHitPoint.copy(this.currentRayHit.position);
      BattleUtils.globalToLocal(this.currentTarget,localHitPoint);
      this.effects.setLocalEffectsType(getEffectType(local2,local1),local1,localHitPoint);
    }

    private function setNextTickTime(param1:int) : void {
      this.nextTickTime.setInt(param1 + this.isisCC.checkPeriodMsec);
    }

    private function calculateNumTicks(param1:int) : void {
      var local4:* = undefined;
      var local5:* = undefined;
      var local2:Number = this.getCurrentEnergyInShootingMode(param1,this.state);
      var local3:int = this.getEnergyDrainRate(this.state);
      if(local3 > 0) {
        local4 = this.getTicks(this.isisCC.capacity,local3);
        local5 = this.getTicks(local2,local3);
        this.numTicksLeft.setInt(Math.min(local5,local4));
      } else {
        this.numTicksLeft.setInt(int.MAX_VALUE);
      }
    }

    private function getTicks(param1:Number, param2:Number) : Number {
      if(param2 <= 0) {
        return int.MAX_VALUE;
      }
      return param1 * thousand.getInt() / param2 / this.isisCC.checkPeriodMsec;
    }

    private function getEnergyDrainRate(param1:IsisState) : int {
      switch(param1) {
        case IsisState.DAMAGING:
          return this.isisCC.dischargeDamageRate;
        case IsisState.HEALING:
          return this.isisCC.dischargeHealingRate;
        case IsisState.IDLE:
          return this.isisCC.dischargeIdleRate;
        default:
          return 0;
      }
    }

    private function tick(param1:int) : void {
      this.nextTickTime.setInt(param1 + this.isisCC.checkPeriodMsec);
      this.weaponPlatform.getBasicGunParams(basicGunParams);
      this.callback.onTick(param1,this.currentRayHit);
    }

    private function start(param1:int) : void {
      if(!this.shooting) {
        this.shooting = true;
        this.currentRayHit = this.target();
        this.currentTarget = Boolean(this.currentRayHit) ? this.currentRayHit.shape.body : null;
        this.baseTime = this.getBaseTimeInShootingMode(param1,this.getCurrentEnergyInIdleMode(param1),this.state);
        this.changeTargetAndNotifyCallback(param1);
      }
    }

    private function stop(param1:int, param2:Boolean) : void {
      if(this.shooting) {
        this.isisTargetPriorityCalculator.resetTarget();
        this.currentTarget = null;
        this.triggerPulled = false;
        this.shooting = false;
        this.baseTime = this.getBaseTimeInIdleMode(param1,this.getCurrentEnergyInShootingMode(param1,this.state));
        this.numTicksLeft.setInt(0);
        this.effects.stopEffects();
        if(param2) {
          this.callback.stop(param1);
        }
      }
    }

    private function getCurrentEnergyInIdleMode(param1:int) : Number {
      var local2:Number = this.isisCC.capacity;
      var local3:Number = this.isisCC.chargeRate * (param1 - this.baseTime) / thousand.getInt();
      return local3 > local2 ? local2 : local3;
    }

    private function getCurrentEnergyInShootingMode(param1:int, param2:IsisState) : Number {
      var local4:Number = NaN;
      var local3:int = this.getEnergyDrainRate(param2);
      if(local3 > 0) {
        local4 = this.isisCC.capacity - local3 * (param1 - this.baseTime) / thousand.getInt();
        return local4 < 0 ? 0 : Math.min(local4,this.isisCC.capacity);
      }
      return this.isisCC.capacity;
    }

    private function getBaseTime(param1:int, param2:int) : int {
      if(this.shooting) {
        return this.getBaseTimeInShootingMode(param1,param2,this.state);
      }
      return param1 - param2 / this.isisCC.chargeRate * 1000;
    }

    private function getBaseTimeInIdleMode(param1:int, param2:Number) : int {
      return param1 - param2 / this.isisCC.chargeRate * thousand.getInt();
    }

    private function getBaseTimeInShootingMode(param1:int, param2:Number, param3:IsisState) : int {
      var local4:int = this.getEnergyDrainRate(param3);
      if(local4 > 0) {
        return param1 - (this.isisCC.capacity - param2) / local4 * thousand.getInt();
      }
      return getTimer();
    }

    private function target() : RayHit {
      var local2:RayHit = null;
      var local3:Tank = null;
      this.weaponPlatform.getAllGunParams(allGunParams);
      if(this.currentTarget != null) {
        this.initTurretRotationMatrix();
        bonusDirection.transform3(rotationMatrix);
        this.isisDirectionCalculator.setBonusDirection(bonusDirection);
      } else {
        this.isisDirectionCalculator.resetBonusDirection();
      }
      var local1:TargetingResult = this.targetingSystem.target(allGunParams);
      this.calculateLocalBonusDirection(local1);
      if(local1.hasTankHit()) {
        local2 = local1.getSingleHit();
        local3 = local2.shape.body.tank;
        if(local3.health == 0) {
          return null;
        }
        this.isisTargetPriorityCalculator.setTarget(local3);
        return local1.getSingleHit();
      }
      return null;
    }

    private function calculateLocalBonusDirection(param1:TargetingResult) : void {
      bonusDirection.copy(param1.getDirection());
      this.initTurretRotationMatrix();
      bonusDirection.transformTransposed3(rotationMatrix);
    }

    private function initTurretRotationMatrix() : void {
      var local1:Object3D = this.weaponPlatform.getTurret3D();
      rotationMatrix.setRotationMatrix(local1.rotationX,local1.rotationY,local1.rotationZ);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.ISIS_RESISTANCE;
    }

    public function addEnergy(param1:int) : void {
      var local2:int = 0;
      var local4:int = 0;
      var local5:* = undefined;
      var local6:* = undefined;
      var local3:int = getTimer();
      if(this.shooting) {
        local4 = this.getEnergyDrainRate(this.state);
        if(local4 > 0) {
          local2 = param1 / local4 * 1000;
          this.baseTime = Math.min(this.baseTime + local2,local3);
          if(this.currentRayHit != null) {
            local5 = this.getTicks(this.isisCC.capacity,local4);
            local6 = this.getTicks(param1,local4);
            this.numTicksLeft.setInt(Math.min(local6,local5));
          }
        } else {
          this.baseTime = local3;
          this.numTicksLeft.setInt(this.currentTarget == null ? 0 : int.MAX_VALUE);
        }
      } else {
        local2 = param1 / this.isisCC.chargeRate * 1000;
        this.baseTime -= local2;
      }
    }

    public function reconfigure(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      this.isisCC.dischargeDamageRate = param1;
      this.isisCC.dischargeHealingRate = param2;
      this.isisCC.dischargeIdleRate = param3;
      this.singleTargetDirectionProcessor.updateMaxDistance(param4);
      var local5:int = getTimer();
      if(this.shooting) {
        this.baseTime = this.getBaseTimeInShootingMode(local5,this.getCurrentEnergyInShootingMode(local5,this.state),this.state);
      } else {
        this.baseTime = this.getBaseTimeInIdleMode(local5,this.getCurrentEnergyInIdleMode(local5));
      }
      this.addEnergy(this.isisCC.capacity);
      this.tryToResumeShooting();
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.effects.setBuffedMode(param1);
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
      this.stop(getBattleRunner().getPhysicsTime(),true);
      this.triggerPulled = false;
      this.stunStatus = this.getStatus();
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      this.triggerPulled = this.controller.isTriggerPulled();
      this.baseTime = this.getBaseTime(getTimer(),this.stunStatus * this.isisCC.capacity);
      this.stunned = false;
    }
  }
}
