package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;

  [ModelInterface]
  public interface ShellWeaponCommunication {
    function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3) : void;
    function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3, param5:Tank, param6:Vector3) : void;
    function tryToDummyShoot(param1:int, param2:int) : void;
    function tryToHit(param1:int, param2:ShellStates, param3:Tank = null) : void;
  }
}
