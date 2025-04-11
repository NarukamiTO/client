package alternativa.tanks.camera {
  import alternativa.math.Vector3;

  public class CameraPositionData {
    public var t:Number = 0;
    public var extraPitch:Number = 0;
    public var position:Vector3 = new Vector3();

    public function CameraPositionData() {
      super();
    }
  }
}
