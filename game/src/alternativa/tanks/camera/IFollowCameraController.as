package alternativa.tanks.camera {
  import alternativa.math.Vector3;

  public interface IFollowCameraController extends CameraController {
    function setLocked(param1:Boolean) : void;
    function setCurrentState(param1:Vector3, param2:Vector3) : void;
    function setTarget(param1:CameraTarget) : void;
    function getCameraState(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void;
  }
}
