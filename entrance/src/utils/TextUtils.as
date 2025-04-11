package utils {
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Shape;
  import flash.geom.Matrix;
  import flash.geom.Rectangle;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class TextUtils {
    public function TextUtils() {
      super();
    }

    public static function getTextInCells(param1:TextField, param2:int, param3:int, param4:uint = 52224, param5:Number = 0.5, param6:int = 1) : BitmapData {
      var local14:Rectangle = null;
      var local15:int = 0;
      var local16:int = 0;
      var local7:TextFormat = param1.getTextFormat();
      var local8:Object = local7.letterSpacing;
      local7.letterSpacing = 4;
      param1.setTextFormat(local7);
      var local9:int = param1.text.length;
      var local10:BitmapData = new BitmapData(param2 * local9,param3,true,16777215);
      var local11:Shape = new Shape();
      local11.graphics.lineStyle(param6,param4,param5);
      local11.graphics.drawRect(0,0,local9 * param2 - param6,param3 - param6);
      var local12:int = 1;
      while(local12 < local9) {
        local11.graphics.moveTo(local12 * param2,0);
        local11.graphics.lineTo(local12 * param2,param3);
        local12++;
      }
      local10.draw(local11);
      var local13:Matrix = new Matrix();
      local12 = 0;
      while(local12 < local9) {
        local14 = param1.getCharBoundaries(local12);
        local14.width -= 4;
        local15 = Math.round((param2 - local14.width) * 0.5);
        local16 = Math.round((param3 - local14.height) * 0.5);
        local13.tx = -local14.x + local12 * param2 + local15;
        local13.ty = -local14.y + local16;
        local10.draw(param1,local13,null,BlendMode.NORMAL,new Rectangle(local12 * param2 + local15,local14.y + local16,local14.width + 1,local14.height),true);
        local12++;
      }
      local7.letterSpacing = local8;
      param1.setTextFormat(local7);
      return local10;
    }
  }
}
