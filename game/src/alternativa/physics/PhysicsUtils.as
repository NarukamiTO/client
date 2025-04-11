package alternativa.physics {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;

  public class PhysicsUtils {
    public function PhysicsUtils() {
      super();
    }

    public static function setBoxInvInertia(param1:Number, param2:Vector3, param3:Matrix3) : void {
      if(param1 <= 0) {
        throw new ArgumentError();
      }
      param3.copy(Matrix3.ZERO);
      if(param1 == Infinity) {
        return;
      }
      var local4:Number = param2.x * param2.x;
      var local5:Number = param2.y * param2.y;
      var local6:Number = param2.z * param2.z;
      param3.m00 = 3 / (param1 * (local5 + local6));
      param3.m11 = 3 / (param1 * (local6 + local4));
      param3.m22 = 3 / (param1 * (local4 + local5));
    }

    public static function getCylinderInvInertia(param1:Number, param2:Number, param3:Number, param4:Matrix3) : void {
      if(param1 <= 0) {
        throw new ArgumentError();
      }
      param4.copy(Matrix3.ZERO);
      if(param1 == Infinity) {
        return;
      }
      param4.m00 = param4.m11 = 1 / (param1 * (param3 * param3 / 12 + param2 * param2 / 4));
      param4.m22 = 2 / (param1 * param2 * param2);
    }
  }
}
