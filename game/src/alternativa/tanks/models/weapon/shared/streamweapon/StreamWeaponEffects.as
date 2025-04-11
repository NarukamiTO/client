package alternativa.tanks.models.weapon.shared.streamweapon {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  public interface StreamWeaponEffects {
    function startEffects(param1:Body, param2:Vector3, param3:Object3D) : void;
    function stopEffects() : void;
    function updateRange(param1:Number) : void;
    function setBuffedMode(param1:Boolean) : void;
  }
}
