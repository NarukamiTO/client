package alternativa.tanks.models.weapon.smoky {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteSmokyWeapon implements Weapon {
    private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var weaponForces:WeaponForces;
    private var effects:ISmokyEffects;
    private var weaponPlatform:WeaponPlatform;

    public function RemoteSmokyWeapon(param1:WeaponForces, param2:ISmokyEffects) {
      super();
      this.weaponForces = param1;
      this.effects = param2;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
    }

    public function activate() : void {
    }

    public function deactivate() : void {
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
    }

    public function reset() : void {
    }

    public function getStatus() : Number {
      return 0;
    }

    public function simulateShot() : void {
      this.weaponPlatform.getAllGunParams(gunParams);
      this.createShotEffects(gunParams);
    }

    public function simulateStaticShot(param1:Vector3) : void {
      this.weaponPlatform.getAllGunParams(gunParams);
      this.createShotEffects(gunParams);
      this.effects.createExplosionMark(gunParams.barrelOrigin,param1);
      this.effects.createExplosionEffects(param1);
    }

    public function simulateTargetShot(param1:Tank, param2:Vector3, param3:Number, param4:Boolean) : void {
      this.weaponPlatform.getAllGunParams(gunParams);
      this.createShotEffects(gunParams);
      var local5:Vector3 = param2.clone().subtract(gunParams.muzzlePosition).normalize();
      param1.applyWeaponHit(param2,local5,param3 * this.weaponForces.getImpactForce());
      this.effects.createExplosionEffects(param2);
      if(param4) {
        this.effects.createCriticalHitEffects(param1.getBody().state.position);
      }
    }

    private function createShotEffects(param1:AllGlobalGunParams) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(param1.muzzlePosition,param1.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.SMOKY_RESISTANCE;
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
