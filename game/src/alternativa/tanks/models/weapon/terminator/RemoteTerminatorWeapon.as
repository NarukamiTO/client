package alternativa.tanks.models.weapon.terminator {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.railgun.RailgunData;
  import alternativa.tanks.models.weapon.railgun.RailgunUtils;
  import alternativa.tanks.models.weapon.rocketlauncher.Rocket;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import alternativa.tanks.physics.CollisionGroup;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteTerminatorWeapon implements Weapon {
    [Inject]
    public static var battleService:BattleService;

    private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var _commonWeapon:TerminatorCommonWeapon;
    private var weaponPlatform:WeaponPlatform;
    private var target:RocketTargetPoint = new RocketTargetPoint();
    private var railgunData:RailgunData;
    private var weaponForces:WeaponForces;

    public function RemoteTerminatorWeapon(param1:TerminatorCommonWeapon, param2:WeaponForces, param3:RailgunData) {
      super();
      this._commonWeapon = param1;
      this.weaponForces = param2;
      this.railgunData = param3;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this._commonWeapon.init(param1,gunParams);
    }

    public function activate() : void {
    }

    public function enable() : void {
    }

    public function deactivate() : void {
      this.stopEffects();
    }

    public function disable(param1:Boolean) : void {
      this.stopEffects();
    }

    public function reset() : void {
      this.stopEffects();
    }

    private function stopEffects() : void {
      this.commonWeapon.effects.railgunEffects.stopEffects();
      LaserPointer(this.commonWeapon.object.adapt(LaserPointer)).hideLaser();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.ROCKET_LAUNCHER_RESISTANCE;
    }

    public function createPrimaryShotEffect(param1:Vector3, param2:Vector.<Body>, param3:Vector.<Vector3>, param4:int) : void {
      var local6:Vector3 = null;
      var local7:Number = NaN;
      var local8:int = 0;
      var local9:Body = null;
      var local10:Vector3 = null;
      var local11:Tank = null;
      this.commonWeapon.effects.createRecoilEffect(param4);
      this.weaponPlatform.getAllGunParams(gunParams,param4);
      this.weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      var local5:Vector3 = param1;
      if(param2 != null && param2.length > 0) {
        local6 = new Vector3();
        local6.diff(param3[param3.length - 1],gunParams.barrelOrigin).normalize();
        if(Vector3.isFiniteVector(local6)) {
          if(local5 == null) {
            local5 = RailgunUtils.getDistantPoint(gunParams.barrelOrigin,local6);
          }
          local7 = 1;
          local8 = 0;
          while(local8 < param2.length) {
            local9 = param2[local8];
            if(local9 != null && local9.tank != null) {
              local10 = param3[local8];
              if(Vector3.isFiniteVector(local10)) {
                local11 = local9.tank;
                local11.applyWeaponHit(local10,local6,this.weaponForces.getImpactForce() * local7);
              }
            }
            local7 *= this.railgunData.getWeakeningCoeff();
            local8++;
          }
        }
        this.commonWeapon.effects.railgunEffects.createTargetHitEffects(gunParams.muzzlePosition,param3[param3.length - 1],param3,param2);
      }
      this.commonWeapon.effects.railgunEffects.createShotTrail(gunParams.muzzlePosition,local5,gunParams.direction);
      if(param1 != null) {
        this.commonWeapon.effects.railgunEffects.createStaticHitMark(gunParams.barrelOrigin,param1);
        this.commonWeapon.effects.railgunEffects.createStaticHitEffect(gunParams.muzzlePosition,param1,this.getStaticHitPointNormal(gunParams.muzzlePosition,param1));
      }
    }

    private function getStaticHitPointNormal(param1:Vector3, param2:Vector3) : Vector3 {
      var local3:Vector3 = param2.clone();
      local3.subtract(param1).normalize();
      var local4:Vector3 = param2.clone();
      local4.subtract(local3);
      var local5:RayHit = new RayHit();
      if(this.weaponPlatform.getBody().scene.collisionDetector.raycastStatic(local4,local3,CollisionGroup.STATIC,100,null,local5)) {
        return local5.normal;
      }
      local3.reverse();
      return local3;
    }

    public function secondaryShoot(param1:int, param2:Vector3, param3:Tank, param4:Vector3) : void {
      this.target.setTank(param3);
      this.target.setLocalPoint(param4);
      this.weaponPlatform.getAllGunParams(gunParams,param1);
      this._commonWeapon.createSecondaryShotEffects(param1);
      var local5:Rocket = Rocket(battleService.getObjectPool().getObject(Rocket));
      local5.init(this._commonWeapon.initParam.secondaryCC,this._commonWeapon.weaponObject.rocketLauncherObject,this.target,param1,this._commonWeapon.effects.rocketLauncherEffects);
      local5.addToGame(gunParams,param2,this.weaponPlatform.getBody(),true,-1);
    }

    public function secondaryDummyShoot(param1:int) : void {
      this.weaponPlatform.getAllGunParams(gunParams,param1);
      this._commonWeapon.createSecondaryShotEffects(param1);
    }

    public function get commonWeapon() : TerminatorCommonWeapon {
      return this._commonWeapon;
    }

    public function destroy() : void {
      this._commonWeapon.destroy();
      this._commonWeapon = null;
      this.weaponPlatform = null;
      this.target.resetTarget();
      this.target = null;
    }

    public function createPrimaryDummyShotEffect(param1:int) : void {
      this.weaponPlatform.getAllGunParams(gunParams,param1);
      this.weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
      this.commonWeapon.effects.forceClosing();
    }

    public function calm(param1:int) : void {
    }
  }
}
