package alternativa.tanks.models.weapon.smoky {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.HitInfo;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.getTimer;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class SmokyWeapon extends BattleRunnerProvider implements Weapon, LogicUnit {
    private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var enabled:Boolean;
    private var nextTime:EncryptedInt = new EncryptedIntImpl();
    private var weaponForces:WeaponForces;
    private var controller:SimpleWeaponController;
    private var targetingSystem:TargetingSystem;
    private var weaponPlatform:WeaponPlatform;
    private var weakening:DistanceWeakening;
    private var callback:SmokyCallback;
    private var effects:ISmokyEffects;
    private var weaponObject:WeaponObject;
    private var stunned:Boolean;
    private var stunEnergy:Number;

    public function SmokyWeapon(param1:WeaponObject, param2:WeaponForces, param3:TargetingSystem, param4:DistanceWeakening, param5:ISmokyEffects, param6:SmokyCallback, param7:SimpleWeaponController) {
      super();
      this.weaponForces = param2;
      this.targetingSystem = param3;
      this.weakening = param4;
      this.effects = param5;
      this.callback = param6;
      this.controller = param7;
      this.weaponObject = param1;
      this.stunned = false;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.controller.init();
      this.reset();
    }

    public function destroy() : void {
      this.weaponForces = null;
      this.targetingSystem = null;
      this.weakening = null;
      this.effects = null;
      this.callback = null;
      this.controller.destroy();
      this.controller = null;
    }

    public function activate() : void {
      getBattleRunner().addLogicUnit(this);
    }

    public function deactivate() : void {
      getBattleRunner().removeLogicUnit(this);
    }

    public function enable() : void {
      this.enabled = true;
      this.controller.discardStoredAction();
    }

    public function disable(param1:Boolean) : void {
      this.enabled = false;
    }

    public function reset() : void {
      this.nextTime.setInt(getTimer());
    }

    public function getStatus() : Number {
      var local1:Number = NaN;
      if(this.stunned) {
        return this.stunEnergy;
      }
      local1 = 1 - (this.nextTime.getInt() - getTimer()) / this.weaponObject.getReloadTimeMS();
      return MathUtils.clamp(local1,0,1);
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.controller.wasActive()) {
        if(this.enabled && param1 >= this.nextTime.getInt() && !this.stunned) {
          this.shoot(param1);
        }
        this.controller.discardStoredAction();
      }
    }

    private function shoot(param1:int) : void {
      var local3:Tank = null;
      var local4:Number = NaN;
      this.nextTime.setInt(param1 + this.weaponObject.getReloadTimeMS());
      this.weaponPlatform.getAllGunParams(gunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
      var local2:HitInfo = new HitInfo();
      if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParams) && this.getTarget(gunParams,local2)) {
        this.effects.createExplosionEffects(local2.position);
        if(BattleUtils.isTankBody(local2.body)) {
          local3 = local2.body.tank;
          local4 = this.weakening.getImpactCoeff(local2.distance);
          local3.applyWeaponHit(local2.position,local2.direction,this.weaponForces.getImpactForce() * local4);
          this.callback.onShotTarget(param1,local2.position,local2.body);
        } else {
          this.effects.createExplosionMark(gunParams.barrelOrigin,local2.position);
          this.callback.onShotStatic(param1,local2.position);
        }
      } else {
        this.callback.onShot(param1);
      }
    }

    private function getTarget(param1:AllGlobalGunParams, param2:HitInfo) : Boolean {
      var local3:TargetingResult = this.targetingSystem.target(param1);
      param2.setResult(param1,local3);
      return local3.hasAnyHit();
    }

    public function createCriticalHitEffect(param1:Vector3) : void {
      this.effects.createCriticalHitEffects(param1);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.SMOKY_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.weaponForces.setRecoilForce(param1);
    }

    public function fullyRecharge() : void {
      this.nextTime.setInt(0);
      this.stunEnergy = 1;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.nextTime.setInt(this.nextTime.getInt() + param2 - param1);
    }

    public function stun() : void {
      this.stunEnergy = this.getStatus();
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      this.nextTime.setInt(this.nextTime.getInt() + param1);
      this.stunned = false;
    }
  }
}
