package alternativa.utils {
  import flash.display.BitmapData;
  import flash.display.BitmapDataChannel;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class BitmapUtils {
    public function BitmapUtils() {
      super();
    }

    public static function mergeBitmapAlpha(bitmapData:BitmapData, alphaBitmapData:BitmapData, dispose:Boolean = false) : BitmapData {
      var res:BitmapData = new BitmapData(bitmapData.width,bitmapData.height);
      res.copyPixels(bitmapData,bitmapData.rect,new Point());
      res.copyChannel(alphaBitmapData,alphaBitmapData.rect,new Point(),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
      if(dispose) {
        bitmapData.dispose();
        alphaBitmapData.dispose();
      }
      return res;
    }

    public static function getFragment(sourceBitmapData:BitmapData, rect:Rectangle) : BitmapData {
      var res:BitmapData = new BitmapData(rect.width,rect.height,sourceBitmapData.transparent,0);
      res.copyPixels(sourceBitmapData,rect,new Point());
      return res;
    }

    public static function getNonTransparentRect(bitmapData:BitmapData) : Rectangle {
      return bitmapData.transparent ? bitmapData.getColorBoundsRect(4278190080,0,false) : bitmapData.rect;
    }
  }
}
