package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.rocketlauncher.Rocket;
  import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherObject;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplodeEvent;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteRocketLauncherWeapon implements Weapon {
    [Inject]
    public static var battleService:BattleService;

    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var weaponObject:RocketLauncherObject;
    private var rocketLauncherParams:RocketLauncherCC;
    private var weaponPlatform:WeaponPlatform;
    private var effects:RocketLauncherEffects;
    private var target:RocketTargetPoint = new RocketTargetPoint();
    private var recoilForce:Number;

    public function RemoteRocketLauncherWeapon(param1:RocketLauncherObject, param2:RocketLauncherCC) {
      super();
      this.weaponObject = param1;
      this.rocketLauncherParams = param2;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.effects = new RocketLauncherEffects(this.weaponObject.getSfxData(),param1.getTurret3D());
      this.recoilForce = this.weaponObject.commonData().getRecoilForce();
    }

    public function destroy() : void {
      this.weaponObject = null;
      this.rocketLauncherParams = null;
      this.weaponPlatform = null;
      this.target.resetTarget();
      this.target = null;
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
      LaserPointer(this.weaponObject.getObject().adapt(LaserPointer)).hideLaser();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.ROCKET_LAUNCHER_RESISTANCE;
    }

    public function dummyShoot(param1:int) : void {
      this.weaponPlatform.getAllGunParams(allGunParams,param1);
      this.createShotEffects(param1);
    }

    public function simpleShoot(param1:int, param2:Vector3, param3:int) : void {
      this.target.resetTarget();
      this.shoot(param3,param1,param2);
    }

    public function salvoShoot(param1:int, param2:Vector3, param3:int, param4:Tank, param5:Vector3) : void {
      this.target.setTank(param4);
      this.target.setLocalPoint(param5);
      this.shoot(param3,param1,param2);
    }

    private function shoot(param1:int, param2:int, param3:Vector3) : void {
      this.weaponPlatform.getAllGunParams(allGunParams,param2);
      this.createShotEffects(param2);
      var local4:Rocket = Rocket(battleService.getObjectPool().getObject(Rocket));
      local4.init(this.rocketLauncherParams,this.weaponObject,this.target,param2,this.effects,RocketExplodeEvent.SINGLE);
      local4.addToGame(allGunParams,param3,this.weaponPlatform.getBody(),true,param1);
    }

    private function createShotEffects(param1:int) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.recoilForce);
      this.weaponPlatform.addDust();
      this.effects.playShotEffect(allGunParams.muzzlePosition,param1);
    }

    public function explodeRocket(param1:int) : void {
      this.weaponObject.dispatchEvent(new RocketExplodeEvent(RocketExplodeEvent.SINGLE,param1));
    }

    public function updateRecoilForce(param1:Number) : void {
      this.recoilForce = param1;
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
