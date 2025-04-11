package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;

  public interface IThunderEffects {
    function createShotEffects(param1:Vector3, param2:Object3D) : void;
    function createExplosionEffects(param1:Vector3) : void;
    function createExplosionMark(param1:Vector3, param2:Vector3) : void;
  }
}
