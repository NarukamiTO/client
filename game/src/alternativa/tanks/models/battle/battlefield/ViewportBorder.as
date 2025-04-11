package alternativa.tanks.models.battle.battlefield {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.geom.Matrix;

  public class ViewportBorder {
    private static var bmpClassCorner1:Class = ViewportBorder_bmpClassCorner1;
    private static var bmdCorner1:BitmapData = Bitmap(new bmpClassCorner1()).bitmapData;
    private static var bmpClassCorner2:Class = ViewportBorder_bmpClassCorner2;
    private static var bmdCorner2:BitmapData = Bitmap(new bmpClassCorner2()).bitmapData;
    private static var bmpClassCorner3:Class = ViewportBorder_bmpClassCorner3;
    private static var bmdCorner3:BitmapData = Bitmap(new bmpClassCorner3()).bitmapData;
    private static var bmpClassCorner4:Class = ViewportBorder_bmpClassCorner4;
    private static var bmdCorner4:BitmapData = Bitmap(new bmpClassCorner4()).bitmapData;
    private static var bmpClassBorderLeft:Class = ViewportBorder_bmpClassBorderLeft;
    private static var bmdBorderLeft:BitmapData = Bitmap(new bmpClassBorderLeft()).bitmapData;
    private static var bmpClassBorderRight:Class = ViewportBorder_bmpClassBorderRight;
    private static var bmdBorderRight:BitmapData = Bitmap(new bmpClassBorderRight()).bitmapData;
    private static var bmpClassBorderTop:Class = ViewportBorder_bmpClassBorderTop;
    private static var bmdBorderTop:BitmapData = Bitmap(new bmpClassBorderTop()).bitmapData;
    private static var bmpClassBorderBottom:Class = ViewportBorder_bmpClassBorderBottom;
    private static var bmdBorderBottom:BitmapData = Bitmap(new bmpClassBorderBottom()).bitmapData;

    public function ViewportBorder() {
      super();
    }

    private static function fillBorderRect(param1:Graphics, param2:BitmapData, param3:int, param4:int, param5:int, param6:int) : void {
      var local7:Matrix = new Matrix();
      local7.tx = param3;
      local7.ty = param4;
      param1.beginBitmapFill(param2,local7);
      param1.drawRect(param3,param4,param5,param6);
      param1.endFill();
    }

    public static function draw(param1:Graphics, param2:int, param3:int) : void {
      var local4:int = 4;
      fillBorderRect(param1,bmdCorner1,local4 - bmdCorner1.width,local4 - bmdCorner1.height,bmdCorner1.width,bmdCorner1.height);
      fillBorderRect(param1,bmdCorner2,param2 - local4,local4 - bmdCorner2.height,bmdCorner2.width,bmdCorner2.height);
      fillBorderRect(param1,bmdCorner3,local4 - bmdCorner3.width,param3 - local4,bmdCorner3.width,bmdCorner3.height);
      fillBorderRect(param1,bmdCorner4,param2 - local4,param3 - local4,bmdCorner4.width,bmdCorner4.height);
      fillBorderRect(param1,bmdBorderTop,local4,local4 - bmdBorderTop.height,param2 - 2 * local4,bmdBorderTop.height);
      fillBorderRect(param1,bmdBorderBottom,local4,param3 - local4,param2 - 2 * local4,bmdBorderBottom.height);
      fillBorderRect(param1,bmdBorderLeft,local4 - bmdBorderLeft.width,local4,bmdBorderLeft.width,param3 - 2 * local4);
      fillBorderRect(param1,bmdBorderRight,param2 - local4,local4,bmdBorderRight.width,param3 - 2 * local4);
    }
  }
}
