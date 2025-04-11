package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;

  public class DistanceScaledAnimatedPlaneEffect extends AnimatedPlaneEffect {
    private static const MIN_DISTANCE:Number = 3000;
    private static const SCALE_COEFFICIENT:Number = 1 / 5000;
    private static const v:Vector3 = new Vector3();

    public function DistanceScaledAnimatedPlaneEffect(param1:Pool) {
      super(param1);
    }

    override public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      var local3:Boolean = super.play(param1,param2);
      if(local3) {
        v.reset(plane.x,plane.y,plane.z);
        local4 = param2.position.distanceTo(v);
        if(local4 > MIN_DISTANCE) {
          scale += local4 * SCALE_COEFFICIENT;
        }
        return true;
      }
      return false;
    }
  }
}
