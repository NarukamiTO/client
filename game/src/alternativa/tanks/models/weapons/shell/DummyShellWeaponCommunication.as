package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;

  public class DummyShellWeaponCommunication implements ShellWeaponCommunication {
    public static const INSTANCE:ShellWeaponCommunication = new DummyShellWeaponCommunication();

    public function DummyShellWeaponCommunication() {
      super();
    }

    public function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3) : void {
    }

    public function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3, param5:Tank, param6:Vector3) : void {
    }

    public function tryToDummyShoot(param1:int, param2:int) : void {
    }

    public function tryToHit(param1:int, param2:ShellStates, param3:Tank = null) : void {
    }
  }
}
