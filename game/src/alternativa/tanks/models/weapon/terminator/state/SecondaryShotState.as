package alternativa.tanks.models.weapon.terminator.state {
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherObject;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.SalvoShotState;
  import alternativa.tanks.models.weapon.terminator.ITerminatorWeapon;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;

  public class SecondaryShotState extends SalvoShotState {
    private var weapon:ITerminatorWeapon;

    public function SecondaryShotState(param1:ITerminatorWeapon, param2:WeaponPlatform, param3:RocketLauncherObject, param4:RocketLauncherCC) {
      super(param1,param2,param3,param4);
      this.weapon = param1;
    }

    override public function start(param1:int) : void {
      super.start(param1);
      if(this.weapon.canShoot(param1)) {
        this.weapon.secondaryOpen(param1);
      }
    }
  }
}
