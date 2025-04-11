package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.physics.CollisionGroup;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteRailgunWeapon implements Weapon {
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();

    private var effects:IRailgunEffects;
    private var weaponPlatform:WeaponPlatform;
    private var railgunData:RailgunData;
    private var weaponForces:WeaponForces;

    public function RemoteRailgunWeapon(param1:WeaponForces, param2:RailgunData, param3:IRailgunEffects) {
      super();
      this.weaponForces = param1;
      this.railgunData = param2;
      this.effects = param3;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
      this.effects.stopEffects();
    }

    public function activate() : void {
    }

    public function deactivate() : void {
      this.effects.stopEffects();
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
      this.effects.stopEffects();
    }

    public function reset() : void {
      this.effects.stopEffects();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function startCharging() : void {
      this.effects.createChargeEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D(),this.railgunData.getChargingTime());
      this.weaponPlatform.getBasicGunParams(basicGunParams);
      this.effects.createSoundEffect(basicGunParams.muzzlePosition,RailgunWeapon.DEFAULT_CHARGE_DURATION - this.railgunData.getChargingTime());
    }

    public function fire(param1:Vector3, param2:Vector.<Body>, param3:Vector.<Vector3>) : void {
      var local5:Vector3 = null;
      var local6:Number = NaN;
      var local7:int = 0;
      var local8:Body = null;
      var local9:Vector3 = null;
      var local10:Tank = null;
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      var local4:Vector3 = param1;
      if(param2 != null && param2.length > 0) {
        local5 = new Vector3();
        local5.diff(param3[param3.length - 1],allGunParams.barrelOrigin).normalize();
        if(Vector3.isFiniteVector(local5)) {
          if(local4 == null) {
            local4 = RailgunUtils.getDistantPoint(allGunParams.barrelOrigin,local5);
          }
          local6 = 1;
          local7 = 0;
          while(local7 < param2.length) {
            local8 = param2[local7];
            if(local8 != null && local8.tank != null) {
              local9 = param3[local7];
              if(Vector3.isFiniteVector(local9)) {
                local10 = local8.tank;
                local10.applyWeaponHit(local9,local5,this.weaponForces.getImpactForce() * local6);
              }
            }
            local6 *= this.railgunData.getWeakeningCoeff();
            local7++;
          }
        }
        this.effects.createTargetHitEffects(allGunParams.muzzlePosition,param3[param3.length - 1],param3,param2);
      }
      this.effects.createShotTrail(allGunParams.muzzlePosition,local4,allGunParams.direction);
      if(param1 != null) {
        this.effects.createStaticHitMark(allGunParams.barrelOrigin,param1);
        this.effects.createStaticHitEffect(allGunParams.muzzlePosition,param1,this.getStaticHitPointNormal(allGunParams.muzzlePosition,param1));
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

    public function fireDummy() : void {
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.RAILGUN_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.weaponForces.setRecoilForce(param1);
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }
  }
}
