package utils {
  import flash.display.BitmapData;

  public class FlipBitmapDataUtils {
    public function FlipBitmapDataUtils() {
      super();
    }

    public static function flipH(param1:BitmapData) : BitmapData {
      var local4:int = 0;
      var local2:BitmapData = new BitmapData(param1.width,param1.height,true);
      var local3:int = 0;
      while(local3 < param1.width) {
        local4 = 0;
        while(local4 < param1.height) {
          local2.setPixel32(local3,local4,param1.getPixel32(param1.width - 1 - local3,local4));
          local4++;
        }
        local3++;
      }
      return local2;
    }

    public static function flipW(param1:BitmapData) : BitmapData {
      var local4:int = 0;
      var local2:BitmapData = new BitmapData(param1.width,param1.height,true);
      var local3:int = 0;
      while(local3 < param1.width) {
        local4 = 0;
        while(local4 < param1.height) {
          local2.setPixel32(local3,local4,param1.getPixel32(local3,param1.height - 1 - local4));
          local4++;
        }
        local3++;
      }
      return local2;
    }
  }
}
