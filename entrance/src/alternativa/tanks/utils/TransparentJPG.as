package alternativa.tanks.utils {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class TransparentJPG {
    public function TransparentJPG() {
      super();
    }

    public static function createImageFromRGBAndAlpha(param1:BitmapData, param2:BitmapData) : Bitmap {
      var local3:Number = param1.width;
      var local4:Number = param1.height;
      var local5:BitmapData = new BitmapData(local3,local4,true,0);
      local5.copyPixels(param1,new Rectangle(0,0,local3,local4),new Point());
      local5.copyChannel(param2,new Rectangle(0,0,local3,local4),new Point(),1,8);
      return new Bitmap(local5);
    }
  }
}
