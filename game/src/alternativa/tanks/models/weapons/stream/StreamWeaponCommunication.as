package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface StreamWeaponCommunication {
    function fireStarted(param1:int) : void;
    function fireStopped(param1:int) : void;
    function targetUpdate(param1:int, param2:Vector3, param3:Tank) : void;
    function targetsUpdateDummy(param1:int, param2:Vector3) : void;
  }
}
