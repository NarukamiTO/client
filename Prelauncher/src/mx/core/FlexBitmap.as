package mx.core {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import mx.utils.NameUtil;

  use namespace mx_internal;

  public class FlexBitmap extends Bitmap {
    mx_internal static const VERSION:String = "4.6.0.23201";

    public function FlexBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false) {
      super(bitmapData,pixelSnapping,smoothing);
      try {
        name = NameUtil.createUniqueName(this);
      }
      catch(e:Error) {
      }
    }

    override public function toString() : String {
      return NameUtil.displayObjectToString(this);
    }
  }
}
