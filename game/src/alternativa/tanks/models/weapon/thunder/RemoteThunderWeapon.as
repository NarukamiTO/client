package alternativa.tanks.models.weapon.thunder {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteThunderWeapon implements Weapon {
    private static const directionToTarget:Vector3 = new Vector3();
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var weaponForces:WeaponForces;
    private var effects:IThunderEffects;
    private var weaponPlatform:WeaponPlatform;
    private var weakening:DistanceWeakening;
    private var splash:Splash;

    public function RemoteThunderWeapon(param1:WeaponForces, param2:DistanceWeakening, param3:Splash, param4:IThunderEffects) {
      super();
      this.weaponForces = param1;
      this.effects = param4;
      this.splash = param3;
      this.weakening = param2;
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

    public function shoot() : void {
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.createCommonShotEffects(allGunParams);
    }

    private function createCommonShotEffects(param1:AllGlobalGunParams) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(param1.muzzlePosition,param1.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
      this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
    }

    public function shootStatic(param1:Vector3) : void {
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.createCommonShotEffects(allGunParams);
      this.effects.createExplosionEffects(param1);
      this.effects.createExplosionMark(allGunParams.barrelOrigin,param1);
      this.applyForceToSplashTargets(param1,null);
    }

    public function shootTarget(param1:Tank, param2:Vector3) : void {
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.createCommonShotEffects(allGunParams);
      this.effects.createExplosionEffects(param2);
      this.applyForceToDirectTarget(param1,param2,allGunParams.muzzlePosition);
      this.applyForceToSplashTargets(param2,param1.getBody());
    }

    private function applyForceToDirectTarget(param1:Tank, param2:Vector3, param3:Vector3) : void {
      var local4:Number = NaN;
      directionToTarget.diff(param2,param3).normalize();
      if(Vector3.isFiniteVector(directionToTarget)) {
        local4 = this.calculateDirectWeakeningCoefficient(param2);
        param1.applyWeaponHit(param2,directionToTarget,this.weaponForces.getImpactForce() * local4);
      }
    }

    private function calculateDirectWeakeningCoefficient(param1:Vector3) : Number {
      return this.weakening.getImpactCoeff(param1.distanceTo(allGunParams.muzzlePosition));
    }

    private function applyForceToSplashTargets(param1:Vector3, param2:Body) : void {
      var local3:Number = this.calculateDirectWeakeningCoefficient(param1);
      this.splash.applySplashForce(param1,local3,param2);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.THUNDER_RESISTANCE;
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
