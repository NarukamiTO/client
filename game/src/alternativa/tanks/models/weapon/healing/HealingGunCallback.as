package alternativa.tanks.models.weapon.healing {
  import alternativa.physics.collision.types.RayHit;

  [ModelInterface]
  public interface HealingGunCallback {
    function updateHit(param1:int, param2:RayHit) : void;
    function stop(param1:int) : void;
    function onTick(param1:int, param2:RayHit) : void;
  }
}
