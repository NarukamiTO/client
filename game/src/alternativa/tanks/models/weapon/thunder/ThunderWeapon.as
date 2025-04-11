package alternativa.tanks.models.weapon.thunder {
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
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.getTimer;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class ThunderWeapon extends BattleRunnerProvider implements Weapon, LogicUnit {
    private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const hitInfo:HitInfo = new HitInfo();

    private var enabled:Boolean;
    private var nextTime:EncryptedInt = new EncryptedIntImpl();
    private var weaponForces:WeaponForces;
    private var controller:SimpleWeaponController;
    private var targetingSystem:TargetingSystem;
    private var weaponPlatform:WeaponPlatform;
    private var weakening:DistanceWeakening;
    private var splash:Splash;
    private var callback:ThunderCallback;
    private var effects:IThunderEffects;
    private var weaponObject:WeaponObject;
    private var stunEnergy:Number;
    private var stunned:Boolean;

    public function ThunderWeapon(param1:WeaponObject, param2:WeaponForces, param3:DistanceWeakening, param4:TargetingSystem, param5:Splash, param6:IThunderEffects, param7:ThunderCallback) {
      super();
      this.weaponObject = param1;
      this.weaponForces = param2;
      this.controller = new SimpleWeaponController();
      this.targetingSystem = param4;
      this.weakening = param3;
      this.splash = param5;
      this.callback = param7;
      this.effects = param6;
      this.stunned = false;
    }

    private static function adjustHitPosition(param1:HitInfo) : void {
      param1.position.add(param1.normal);
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
      this.splash = null;
      this.callback = null;
      this.effects = null;
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
      var local2:Number = NaN;
      var local3:Tank = null;
      this.nextTime.setInt(param1 + this.weaponObject.getReloadTimeMS());
      this.weaponPlatform.getAllGunParams(gunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
      if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParams) && this.getTarget(gunParams,hitInfo)) {
        adjustHitPosition(hitInfo);
        this.effects.createExplosionEffects(hitInfo.position);
        local2 = this.weakening.getImpactCoeff(hitInfo.distance);
        this.splash.applySplashForce(hitInfo.position,local2,hitInfo.body);
        if(BattleUtils.isTankBody(hitInfo.body)) {
          local3 = hitInfo.body.tank;
          local3.applyWeaponHit(hitInfo.position,hitInfo.direction,this.weaponForces.getImpactForce() * local2);
          this.callback.onShotTarget(param1,hitInfo.position,hitInfo.body);
        } else {
          this.effects.createExplosionMark(gunParams.barrelOrigin,hitInfo.position);
          this.callback.onShotStatic(param1,hitInfo.direction);
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

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.THUNDER_RESISTANCE;
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
