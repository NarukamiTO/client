package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class TankBackground extends Sprite {
    private static const bitmapBg:Class = TankBackground_bitmapBg;

    private var bgBitmap:BitmapData = new bitmapBg().bitmapData;
    private var bg:Shape;

    public function TankBackground() {
      super();
      this.bg = new Shape();
      addChild(this.bg);
    }

    public function redraw(stageWidth:int, stageHeight:int) : void {
      this.bg.graphics.clear();
      this.bg.graphics.beginBitmapFill(this.bgBitmap);
      this.bg.graphics.drawRect(0,0,stageWidth,stageHeight);
    }
  }
}
