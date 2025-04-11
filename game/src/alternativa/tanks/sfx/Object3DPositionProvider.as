package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.camera.GameCamera;

  public interface Object3DPositionProvider {
    function initPosition(param1:Object3D) : void;
    function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void;
    function destroy() : void;
  }
}
