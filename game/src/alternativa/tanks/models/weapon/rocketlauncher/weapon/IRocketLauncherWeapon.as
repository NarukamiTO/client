package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.AimWeaponStatus;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;

  public interface IRocketLauncherWeapon extends AimWeaponStatus {
    function getTargetingSystem() : TargetingSystem;
    function getTarget() : RocketTargetPoint;
    function canShoot(param1:int) : Boolean;
    function salvoShoot(param1:int, param2:Number) : void;
    function getEffects() : RocketLauncherEffects;
    function onEndingOfSalvo(param1:int) : void;
    function isBuffed() : Boolean;
  }
}
