package alternativa.tanks.utils {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import flash.utils.Dictionary;

  public class Colorizer {
    public function Colorizer() {
      super();
    }

    public static function getColorizedMaterial(param1:Dictionary, param2:uint, param3:BitmapData, param4:Boolean = true) : TextureMaterial {
      var local5:TextureMaterial = param1[param2];
      if(local5 == null) {
        local5 = new TextureMaterial(colorize(param3,param2,0.75),param4,true,MipMapping.PER_PIXEL);
        param1[param2] = local5;
      }
      return local5;
    }

    public static function colorize(param1:BitmapData, param2:int, param3:Number = 1) : BitmapData {
      var local4:Number = param3 * (param2 >> 16 & 0xFF) / 255;
      var local5:Number = param3 * (param2 >> 8 & 0xFF) / 255;
      var local6:Number = param3 * (param2 & 0xFF) / 255;
      var local7:BitmapData = param1.clone();
      local7.colorTransform(param1.rect,new ColorTransform(local4,local5,local6));
      return local7;
    }
  }
}
