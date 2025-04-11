package alternativa.tanks.camera {
  import alternativa.math.Vector3;

  public interface CameraTarget {
    function getCameraParams(param1:Vector3, param2:Vector3) : void;
  }
}
