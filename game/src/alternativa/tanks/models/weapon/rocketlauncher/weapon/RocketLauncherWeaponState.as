package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import platform.client.fp10.core.type.AutoClosable;

  public interface RocketLauncherWeaponState extends AutoClosable {
    function start(param1:int) : void;
    function stop(param1:int) : void;
    function getStatus() : Number;
    function update(param1:int) : void;
    function getReloadTime() : int;
    function weaponStunned(param1:int) : void;
  }
}
