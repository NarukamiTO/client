package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface GaussWeaponCallback {
    function doPrimaryShot(param1:int, param2:Vector3) : void;
    function doSecondaryShot(param1:IGameObject, param2:Vector3, param3:Vector3) : void;
    function doDummyShot() : void;
    function doStartAiming() : void;
    function doStopAiming() : void;
    function doPrimaryHitStatic(param1:int, param2:Vector3) : void;
    function doPrimaryHitTarget(param1:int, param2:IGameObject, param3:Vector3, param4:Vector3) : void;
  }
}
