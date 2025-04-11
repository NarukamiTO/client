package platform.client.fp10.core.resource {
  import flash.display.BitmapData;
  import flash.display.BitmapDataChannel;
  import flash.display.BlendMode;
  import flash.geom.Matrix;
  import flash.geom.Point;

  public class ResourceUtils {
    public function ResourceUtils() {
      super();
    }

    public static function mergeBitmapAlpha(param1:BitmapData, param2:BitmapData, param3:Boolean = false) : BitmapData {
      var local6:BitmapData = null;
      var local4:BitmapData = new BitmapData(param1.width,param1.height);
      var local5:Point = new Point();
      local4.copyPixels(param1,param1.rect,local5);
      if(param1.width != param2.width || param1.height != param2.height) {
        local6 = param2;
        param2 = new BitmapData(param1.width,param1.height);
        param2.draw(local6,new Matrix(param1.width / local6.width,0,0,param1.height / local6.height),null,BlendMode.NORMAL,null,true);
      }
      local4.copyChannel(param2,param2.rect,local5,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
      if(local6 != null) {
        param2.dispose();
        param2 = local6;
      }
      if(param3) {
        param1.dispose();
        param2.dispose();
      }
      return local4;
    }
  }
}
