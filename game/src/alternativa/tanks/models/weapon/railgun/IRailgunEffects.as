package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  public interface IRailgunEffects {
    function createChargeEffect(param1:Vector3, param2:Object3D, param3:int) : void;
    function createSoundEffect(param1:Vector3, param2:int) : void;
    function createShotTrail(param1:Vector3, param2:Vector3, param3:Vector3) : void;
    function createStaticHitMark(param1:Vector3, param2:Vector3) : void;
    function createTargetHitEffects(param1:Vector3, param2:Vector3, param3:Vector.<Vector3>, param4:Vector.<Body>) : void;
    function createStaticHitEffect(param1:Vector3, param2:Vector3, param3:Vector3) : void;
    function stopEffects() : void;
  }
}
