package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.getTimer;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RailgunWeapon extends BattleRunnerProvider implements Weapon, LogicUnit {
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();

    public static var DEFAULT_CHARGE_DURATION:int = 1100;

    private var controller:SimpleWeaponController;
    private var targetingSystem:TargetingSystem;
    private var weaponObject:WeaponObject;
    private var weaponForces:WeaponForces;
    private var weakeningCoeff:Number;
    private var chargingDuration:EncryptedInt = new EncryptedIntImpl();
    private var effects:IRailgunEffects;
    private var callback:RailgunCallback;
    private var weaponPlatform:WeaponPlatform;
    private var enabled:Boolean;
    private var stunned:Boolean;
    private var nextTime:EncryptedInt = new EncryptedIntImpl();
    private var charging:Boolean;
    private var stunStatus:Number = 0;
    private var transitionChargingTime:int;

    public function RailgunWeapon(param1:TargetingSystem, param2:SimpleWeaponController, param3:WeaponObject, param4:WeaponForces, param5:Number, param6:int, param7:IRailgunEffects, param8:RailgunCallback) {
      super();
      this.targetingSystem = param1;
      this.controller = param2;
      this.weaponObject = param3;
      this.weaponForces = param4;
      this.weakeningCoeff = param5;
      this.chargingDuration.setInt(param6);
      this.effects = param7;
      this.callback = param8;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.controller.init();
    }

    public function destroy() : void {
      this.deactivate();
      this.effects.stopEffects();
      this.controller.destroy();
      this.controller = null;
      this.effects = null;
      this.weaponForces = null;
      this.targetingSystem = null;
      this.callback = null;
    }

    public function activate() : void {
      getBattleRunner().addLogicUnit(this);
    }

    public function deactivate() : void {
      getBattleRunner().removeLogicUnit(this);
    }

    public function enable() : void {
      if(!this.enabled) {
        this.enabled = true;
        this.controller.discardStoredAction();
      }
    }

    public function disable(param1:Boolean) : void {
      if(this.enabled) {
        this.enabled = false;
        this.effects.stopEffects();
      }
    }

    public function reset() : void {
      this.enabled = false;
      this.effects.stopEffects();
      this.nextTime.setInt(0);
      this.charging = false;
      this.transitionChargingTime = 0;
    }

    public function getStatus() : Number {
      var local1:* = undefined;
      if(this.charging) {
        local1 = this.transitionChargingTime > 0 ? this.transitionChargingTime : this.chargingDuration.getInt();
        return MathUtils.clamp((this.nextTime.getInt() - getTimer()) / local1,0,1);
      }
      if(this.stunned) {
        return this.stunStatus;
      }
      return MathUtils.clamp(1 - (this.nextTime.getInt() - getTimer()) / this.weaponObject.getReloadTimeMS(),0,1);
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.charging) {
        if(param1 >= this.nextTime.getInt()) {
          if(!this.stunned) {
            this.shoot(param1);
          } else {
            this.stunStatus = 0;
            this.charging = false;
          }
        }
      } else if(this.enabled && !this.stunned) {
        if(param1 >= this.nextTime.getInt() && this.controller.wasActive()) {
          this.startCharging(param1);
        }
      }
      this.controller.discardStoredAction();
    }

    private function startCharging(param1:int) : void {
      this.charging = true;
      this.transitionChargingTime = 0;
      this.nextTime.setInt(param1 + this.chargingDuration.getInt());
      this.effects.createChargeEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D(),this.chargingDuration.getInt());
      this.weaponPlatform.getBasicGunParams(basicGunParams);
      this.effects.createSoundEffect(basicGunParams.muzzlePosition,DEFAULT_CHARGE_DURATION - this.chargingDuration.getInt());
      this.callback.onStartCharging(param1);
    }

    private function shoot(param1:int) : void {
      var local2:RailgunShotResult = null;
      this.charging = false;
      this.transitionChargingTime = 0;
      this.nextTime.setInt(param1 + this.weaponObject.getReloadTimeMS());
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams)) {
        local2 = new RailgunShotResult();
        local2.setFromTargetingResult(this.targetingSystem.target(allGunParams));
        if(local2.hitPoints.length > 0) {
          this.applyImpactToTargets(local2);
        }
        this.createShotEffect(local2,allGunParams);
        this.callback.onShot(param1,local2.getStaticHitPoint(),local2.targets,local2.hitPoints);
      } else {
        this.callback.onShotDummy(param1);
      }
    }

    private function applyImpactToTargets(param1:RailgunShotResult) : void {
      var local4:Body = null;
      var local5:Tank = null;
      var local2:Number = 1;
      var local3:int = 0;
      while(local3 < param1.targets.length) {
        local4 = param1.targets[local3];
        local5 = local4.tank;
        local5.applyWeaponHit(param1.hitPoints[local3],param1.shotDirection,this.weaponForces.getImpactForce() * local2);
        local2 *= this.weakeningCoeff;
        local3++;
      }
    }

    private function createShotEffect(param1:RailgunShotResult, param2:AllGlobalGunParams) : void {
      var local3:Vector3 = param1.getStaticHitPoint();
      if(local3 == null && param1.targets.length > 0) {
        local3 = RailgunUtils.getDistantPoint(param2.barrelOrigin,param1.shotDirection);
      }
      this.effects.createShotTrail(param2.muzzlePosition,local3,param2.direction);
      this.effects.createStaticHitMark(param2.barrelOrigin,param1.getStaticHitPoint());
      if(local3 != null) {
        if(param1.hasStaticHit) {
          this.effects.createStaticHitEffect(param2.muzzlePosition,param1.staticHitPoint,param1.staticHitNormal);
        }
        if(param1.targets.length > 0) {
          this.effects.createTargetHitEffects(param2.muzzlePosition,local3,param1.hitPoints,param1.targets);
        }
      }
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.RAILGUN_RESISTANCE;
    }

    public function updateChargingTime(param1:int) : void {
      if(this.charging) {
        this.transitionChargingTime = this.chargingDuration.getInt();
      }
      this.chargingDuration.setInt(param1);
    }

    public function updateRecoilForce(param1:Number) : void {
      this.weaponForces.setRecoilForce(param1);
    }

    public function fullyRecharge() : void {
      var local1:int = int(battleService.getPhysicsTime());
      if(this.nextTime.getInt() > local1 && !this.charging) {
        this.nextTime.setInt(local1);
      }
      this.stunStatus = 1;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      if(!this.charging || param1 > param2) {
        this.nextTime.setInt(this.nextTime.getInt() - param1 + param2);
      }
    }

    public function stun() : void {
      this.stunStatus = this.charging ? 1 : this.getStatus();
      this.charging = false;
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      if(this.stunStatus < 1) {
        this.nextTime.setInt(this.nextTime.getInt() + param1);
      }
      this.stunned = false;
    }
  }
}
