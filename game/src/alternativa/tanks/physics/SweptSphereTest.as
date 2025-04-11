package alternativa.tanks.physics {
  import alternativa.math.Vector3;

  public class SweptSphereTest {
    private static const A:Vector3 = new Vector3();
    private static const V:Vector3 = new Vector3();

    public function SweptSphereTest() {
      super();
    }

    public static function test(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3, param5:Vector3, param6:Number, param7:Number) : Boolean {
      A.diff(param1,param4);
      var local8:Number = param3 + param6;
      var local9:Number = A.dot(A) - local8 * local8;
      if(local9 < 0) {
        return true;
      }
      V.diff(param2,param5);
      var local10:Number = V.dot(V);
      if(local10 < 0.0001) {
        return false;
      }
      var local11:Number = A.dot(V);
      if(local11 > 0) {
        return false;
      }
      var local12:Number = local11 * local11 - local10 * local9;
      if(local12 < 0) {
        return false;
      }
      var local13:Number = Math.sqrt(local12);
      var local14:Number = (-local11 - local13) / local10;
      return local14 < param7;
    }
  }
}
