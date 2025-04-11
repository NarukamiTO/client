package alternativa.tanks.services.colortransform {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.Color;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  public class ColorTransformUtils {
    public function ColorTransformUtils() {
      super();
    }

    public static function transformBitmap(param1:BitmapData, param2:ColorTransform) : BitmapData {
      var local3:BitmapData = param1.clone();
      local3.colorTransform(local3.rect,param2);
      return local3;
    }

    public static function equal(param1:ColorTransform, param2:ColorTransform) : Boolean {
      if(param1 == param2) {
        return true;
      }
      if(param1 == null || param2 == null) {
        return false;
      }
      return param1.redMultiplier == param2.redMultiplier && param1.greenMultiplier == param2.greenMultiplier && param1.blueMultiplier == param2.blueMultiplier && param1.alphaMultiplier == param2.alphaMultiplier && param1.redOffset == param2.redOffset && param1.greenOffset == param2.greenOffset && param1.blueOffset == param2.blueOffset && param1.alphaOffset == param2.alphaOffset;
    }

    public static function clone(param1:ColorTransform) : ColorTransform {
      if(param1 == null) {
        return null;
      }
      return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
    }

    public static function toString(param1:ColorTransform) : String {
      if(param1 == null) {
        return "null";
      }
      return param1.toString();
    }

    public static function calculateColorTransform(param1:DynamicShadowParams, param2:Number) : ColorTransform {
      var local3:Color = null;
      var local4:Color = null;
      var local5:Matrix3 = null;
      var local6:Vector3 = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:ColorTransform = null;
      if(!GPUCapabilities.gpuEnabled || Boolean(GPUCapabilities.constrained)) {
        local3 = new Color(param1.lightColor);
        local4 = new Color(param1.shadowColor);
        local3.subtract(local4);
        local5 = new Matrix3();
        local5.setRotationMatrix(param1.angleX,0,param1.angleZ);
        local6 = new Vector3(0,1,0);
        local6.transform3(local5);
        local6.normalize();
        local7 = Math.abs(local6.z) * param2;
        local8 = (local4.getColor() >> 16 & 0xFF) / 255;
        local9 = (local4.getColor() >> 8 & 0xFF) / 255;
        local10 = (local4.getColor() & 0xFF) / 255;
        local11 = (local3.getColor() >> 16 & 0xFF) / 255;
        local12 = (local3.getColor() >> 8 & 0xFF) / 255;
        local13 = (local3.getColor() & 0xFF) / 255;
        local14 = new ColorTransform();
        local14.redMultiplier = 2 * (local8 + local11 * local7);
        local14.greenMultiplier = 2 * (local9 + local12 * local7);
        local14.blueMultiplier = 2 * (local10 + local13 * local7);
        return local14;
      }
      return null;
    }
  }
}
