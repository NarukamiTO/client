package alternativa.tanks.models.tank {
  public interface IWeaponController {
    function activateWeapon() : void;
    function deactivateWeapon() : void;
    function lockWeapon(param1:int, param2:Boolean) : void;
    function unlockWeapon(param1:int) : void;
  }
}
