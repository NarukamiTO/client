package alternativa.tanks.models.weapon.terminator {
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.IRocketLauncherWeapon;

  public interface ITerminatorWeapon extends IRocketLauncherWeapon {
    function getPrimaryNextChargeTime() : int;
    function getPrimaryNextShotTime() : int;
    function secondaryOpen(param1:int) : void;
    function secondaryHide(param1:int) : void;
    function isShooting() : Boolean;
    function switchToSecondaryState(param1:int) : void;
    function shootPrimary(param1:int) : void;
    function startCharging(param1:int) : void;
    function resetPrimaryNextShotTime() : void;
  }
}
