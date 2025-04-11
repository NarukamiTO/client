package alternativa.tanks.models.weapon.shared.streamweapon {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shared.ConicAreaTargetingSystem;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import flash.utils.getTimer;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class StreamWeapon extends BattleRunnerProvider implements Weapon, LogicUnit, LocalWeapon {
    private static const milliseconds:EncryptedInt = new EncryptedIntImpl(1000);
    private static const FIRE_ORIGIN_OFFSET_COEFF:Number = 0.3;
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const targetBodies:Vector.<Body> = new Vector.<Body>();
    private static const targetDistances:Vector.<Number> = new Vector.<Number>();
    private static const targetHitPoints:Vector.<Vector3> = new Vector.<Vector3>();
    private static const ALMOST_ZERO:Number = 0.001;

    private var energyCapacity:EncryptedNumber = new EncryptedNumberImpl();
    private var energyDrainSpeed:EncryptedNumber = new EncryptedNumberImpl();
    private var energyRechargeSpeed:EncryptedNumber = new EncryptedNumberImpl();
    private var tickInterval:EncryptedInt = new EncryptedIntImpl();
    private var targetingSystem:ConicAreaTargetingSystem;
    private var controller:SimpleWeaponController;
    private var callback:IStreamWeaponCallback;
    private var effects:StreamWeaponEffects;
    private var weaponPlatform:WeaponPlatform;
    private var nextTickTime:EncryptedInt = new EncryptedIntImpl();
    private var enabled:Boolean;
    private var triggerPulled:Boolean;
    private var shooting:Boolean;
    private var currentTime:int;
    private var baseTime:EncryptedInt = new EncryptedIntImpl();
    private var numTicksLeft:EncryptedInt = new EncryptedIntImpl();
    private var resistanceProperty:ItemProperty;
    private var stunStatus:Number;
    private var stunned:Boolean;

    public function StreamWeapon(param1:Number, param2:Number, param3:Number, param4:int, param5:ConicAreaTargetingSystem, param6:SimpleWeaponController, param7:IStreamWeaponCallback, param8:StreamWeaponEffects, param9:ItemProperty) {
      super();
      this.energyCapacity.setNumber(param1);
      this.energyDrainSpeed.setNumber(param2);
      this.energyRechargeSpeed.setNumber(param3);
      this.tickInterval.setInt(param4);
      this.targetingSystem = param5;
      this.controller = param6;
      this.callback = param7;
      this.effects = param8;
      this.resistanceProperty = param9;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.controller.init();
      this.controller.setWeapon(this);
    }

    public function destroy() : void {
      this.targetingSystem = null;
      this.effects = null;
      this.callback = null;
      this.controller.destroy();
      this.controller = null;
      this.weaponPlatform = null;
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
      this.shooting = false;
      this.triggerPulled = false;
      this.baseTime.setInt(0);
      this.nextTickTime.setInt(0);
      this.numTicksLeft.setInt(0);
    }

    public function pullTrigger() : void {
      if(this.enabled) {
        this.triggerPulled = true;
      }
    }

    public function releaseTrigger() : void {
      this.triggerPulled = false;
    }

    public function getStatus() : Number {
      var local1:Number = NaN;
      if(this.stunned) {
        return this.stunStatus;
      }
      if(this.triggerPulled) {
        local1 = this.getCurrentEnergyInShootingMode(getTimer());
      } else {
        local1 = this.getCurrentEnergyInIdleMode(getTimer());
      }
      return local1 / this.energyCapacity.getNumber();
    }

    public function runLogic(param1:int, param2:int) : void {
      this.currentTime = param1;
      if(this.enabled && !this.stunned) {
        if(this.shooting) {
          this.runLogicForShootingMode(param1);
        } else {
          this.runLogicForIdleMode(param1);
        }
      }
    }

    private function runLogicForShootingMode(param1:int) : void {
      if(this.triggerPulled) {
        this.tryToTick(param1);
        this.stopIfNecessary(param1);
      } else {
        this.stop(param1,true);
      }
    }

    private function tryToTick(param1:int) : void {
      if(this.numTicksLeft.getInt() > 0) {
        if(this.nextTickTime.getInt() <= param1) {
          this.tick(param1);
          this.numTicksLeft.setInt(this.numTicksLeft.getInt() - 1);
        }
      }
    }

    private function stopIfNecessary(param1:int) : void {
      if(this.numTicksLeft.getInt() == 0) {
        if(this.getCurrentEnergyInShootingMode(param1) <= 0) {
          this.stop(param1,true);
        }
      }
    }

    private function runLogicForIdleMode(param1:int) : void {
      if(this.triggerPulled) {
        this.start(param1);
      }
    }

    private function start(param1:int) : void {
      var local2:Number = NaN;
      if(!this.shooting) {
        this.shooting = true;
        local2 = this.getCurrentEnergyInIdleMode(param1);
        this.baseTime.setInt(this.getBaseTimeForShootingMode(param1,local2));
        this.calculateTicksNumber(local2);
        this.nextTickTime.setInt(param1 + this.tickInterval.getInt());
        this.effects.startEffects(this.weaponPlatform.getBody(),this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
        this.callback.start(param1);
      }
    }

    private function calculateTicksNumber(param1:Number) : void {
      if(this.energyDrainSpeed.getNumber() > ALMOST_ZERO) {
        this.numTicksLeft.setInt(milliseconds.getInt() * param1 / (this.energyDrainSpeed.getNumber() * this.tickInterval.getInt()));
      } else {
        this.numTicksLeft.setInt(int.MAX_VALUE);
      }
    }

    private function stop(param1:int, param2:Boolean) : void {
      if(this.shooting) {
        this.triggerPulled = false;
        this.shooting = false;
        this.baseTime.setInt(param1 - this.getCurrentEnergyInShootingMode(param1) / this.energyRechargeSpeed.getNumber() * milliseconds.getInt());
        this.numTicksLeft.setInt(0);
        this.effects.stopEffects();
        if(param2) {
          this.callback.stop(param1);
        }
      }
    }

    private function tick(param1:int) : void {
      var local6:Body = null;
      this.nextTickTime.setInt(param1 + this.tickInterval.getInt());
      var local2:Vector3 = this.weaponPlatform.getLocalMuzzlePosition();
      this.weaponPlatform.getAllGunParams(allGunParams);
      var local3:Number = local2.y;
      targetBodies.length = 0;
      targetDistances.length = 0;
      targetHitPoints.length = 0;
      this.targetingSystem.getTargets(this.weaponPlatform.getBody(),local3,FIRE_ORIGIN_OFFSET_COEFF,allGunParams.barrelOrigin,allGunParams.direction,allGunParams.elevationAxis,targetBodies,targetDistances,targetHitPoints);
      var local4:int = int(targetBodies.length);
      if(local4 > 0) {
        this.callback.onTick(this,targetBodies,targetDistances,targetHitPoints,param1);
      }
      var local5:int = 0;
      while(local5 < targetBodies.length) {
        local6 = targetBodies[local5];
        local6.tank.setLastHitPoint(targetHitPoints[local5]);
        local5++;
      }
      targetBodies.length = 0;
      targetDistances.length = 0;
      targetHitPoints.length = 0;
    }

    private function getCurrentEnergyInIdleMode(param1:int) : Number {
      var local2:Number = Number(this.energyCapacity.getNumber());
      var local3:Number = this.energyRechargeSpeed.getNumber() * (param1 - this.baseTime.getInt()) / milliseconds.getInt();
      return local3 > local2 ? local2 : local3;
    }

    private function getCurrentEnergyInShootingMode(param1:int) : Number {
      var local2:Number = this.energyCapacity.getNumber() - this.energyDrainSpeed.getNumber() * (param1 - this.baseTime.getInt()) / milliseconds.getInt();
      return local2 < 0 ? 0 : local2;
    }

    private function getBaseTimeForShootingMode(param1:int, param2:Number) : int {
      if(this.energyDrainSpeed.getNumber() > ALMOST_ZERO) {
        return param1 - (this.energyCapacity.getNumber() - param2) / this.energyDrainSpeed.getNumber() * milliseconds.getInt();
      }
      return param1;
    }

    public function getResistanceProperty() : ItemProperty {
      return this.resistanceProperty;
    }

    public function updateRange(param1:Number) : void {
      this.effects.updateRange(param1);
      this.targetingSystem.updateRange(param1);
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.effects.setBuffedMode(param1);
      this.tryToResumeShooting();
    }

    private function tryToResumeShooting() : void {
      if(!this.triggerPulled && this.controller.isTriggerPulled()) {
        this.pullTrigger();
      }
    }

    public function updateDischargeRate(param1:Number) : void {
      this.energyDrainSpeed.setNumber(param1);
    }

    private function getBaseTime(param1:int, param2:int) : int {
      if(this.shooting) {
        return this.getBaseTimeForShootingMode(param1,param2);
      }
      return param1 - param2 / this.energyRechargeSpeed.getNumber() * milliseconds.getInt();
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
      this.calculateTicksNumber(this.energyCapacity.getNumber());
      this.baseTime.setInt(this.getBaseTime(this.currentTime,this.energyCapacity.getNumber()));
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
      this.baseTime.setInt(this.getBaseTime(getTimer(),this.stunStatus * this.energyCapacity.getNumber()));
      this.stunned = false;
    }
  }
}
