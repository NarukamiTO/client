package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import flash.geom.ColorTransform;

  public class SFXUtils {
    private static var axis1:Vector3 = new Vector3();
    private static var axis2:Vector3 = new Vector3();
    private static var eulerAngles:Vector3 = new Vector3();
    private static var targetAxisZ:Vector3 = new Vector3();
    private static var objectAxis:Vector3 = new Vector3();
    private static var matrix1:Matrix3 = new Matrix3();
    private static var matrix2:Matrix3 = new Matrix3();

    public function SFXUtils() {
      super();
    }

    public static function alignObjectPlaneToView(param1:Object3D, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      var local5:Number = NaN;
      var local6:Number = NaN;
      if(param3.y < -0.9999999 || param3.y > 0.9999999) {
        axis1.x = 0;
        axis1.y = 0;
        axis1.z = 1;
        local5 = param3.y < 0 ? Math.PI : 0;
      } else {
        axis1.x = param3.z;
        axis1.y = 0;
        axis1.z = -param3.x;
        axis1.normalize();
        local5 = Math.acos(param3.y);
      }
      matrix1.fromAxisAngle(axis1,local5);
      targetAxisZ.x = param4.x - param2.x;
      targetAxisZ.y = param4.y - param2.y;
      targetAxisZ.z = param4.z - param2.z;
      local6 = targetAxisZ.x * param3.x + targetAxisZ.y * param3.y + targetAxisZ.z * param3.z;
      targetAxisZ.x -= local6 * param3.x;
      targetAxisZ.y -= local6 * param3.y;
      targetAxisZ.z -= local6 * param3.z;
      targetAxisZ.normalize();
      matrix1.transformVector(Vector3.Z_AXIS,objectAxis);
      local6 = objectAxis.x * targetAxisZ.x + objectAxis.y * targetAxisZ.y + objectAxis.z * targetAxisZ.z;
      axis2.x = objectAxis.y * targetAxisZ.z - objectAxis.z * targetAxisZ.y;
      axis2.y = objectAxis.z * targetAxisZ.x - objectAxis.x * targetAxisZ.z;
      axis2.z = objectAxis.x * targetAxisZ.y - objectAxis.y * targetAxisZ.x;
      axis2.normalize();
      local5 = Math.acos(local6);
      matrix2.fromAxisAngle(axis2,local5);
      matrix1.append(matrix2);
      matrix1.getEulerAngles(eulerAngles);
      param1.rotationX = eulerAngles.x;
      param1.rotationY = eulerAngles.y;
      param1.rotationZ = eulerAngles.z;
      param1.x = param2.x;
      param1.y = param2.y;
      param1.z = param2.z;
    }

    public static function setEffectParams(param1:Object3D) : void {
      param1.softAttenuation = 80;
      param1.useLight = false;
      param1.shadowMapAlphaThreshold = 2;
      param1.depthMapAlphaThreshold = 2;
      param1.useShadowMap = false;
    }

    public static function copyColorTransform(param1:ColorTransform, param2:ColorTransform) : void {
      param2.redMultiplier = param1.redMultiplier;
      param2.greenMultiplier = param1.greenMultiplier;
      param2.blueMultiplier = param1.blueMultiplier;
      param2.alphaMultiplier = param1.alphaMultiplier;
      param2.redOffset = param1.redOffset;
      param2.greenOffset = param1.greenOffset;
      param2.blueOffset = param1.blueOffset;
      param2.alphaOffset = param1.alphaOffset;
    }

    public static function calculateAlphaForObject(param1:Object3D, param2:Vector3, param3:Vector3, param4:Boolean, param5:Number, param6:Number) : void {
      var local7:Number = param2.x - param1.x;
      var local8:Number = param2.y - param1.y;
      var local9:Number = param2.z - param1.z;
      var local10:Number = Math.sqrt(local7 * local7 + local8 * local8 + local9 * local9);
      local7 /= local10;
      local8 /= local10;
      local9 /= local10;
      var local11:Number = Math.abs(local7 * param3.x + local8 * param3.y + local9 * param3.z);
      if(param4) {
        local11 = 1 - local11;
      }
      local11 = Math.pow(local11,param5);
      param1.alpha = 1 - local11 / param6;
      if(param1.alpha < 0) {
        param1.alpha = 0;
      }
    }
  }
}
