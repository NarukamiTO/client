package alternativa.tanks.models.weapons.targeting.processor {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;

  public interface TargetingDirectionProcessor {
    function process(param1:AllGlobalGunParams, param2:Vector3) : Vector.<RayHit>;
    function setShotFromMuzzle() : void;
  }
}
