package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;

  [ModelInterface]
  public interface ShellWeaponListener {
    function onShot(param1:int, param2:int, param3:Vector3) : void;
    function onDummyShot(param1:int) : void;
  }
}
