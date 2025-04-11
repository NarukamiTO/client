package alternativa.tanks.view.battleinfo.renderer {
  import controls.cellrenderer.ButtonState;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;

  public class CellBlue extends ButtonState {
    private static const cellFullLeft:Class = CellBlue_cellFullLeft;
    private static const cellFullLeftData:BitmapData = Bitmap(new cellFullLeft()).bitmapData;
    private static const cellFullCenter:Class = CellBlue_cellFullCenter;
    private static const cellFullCenterData:BitmapData = Bitmap(new cellFullCenter()).bitmapData;
    private static const cellFullRight:Class = CellBlue_cellFullRight;
    private static const cellFullRightData:BitmapData = Bitmap(new cellFullRight()).bitmapData;

    public function CellBlue() {
      super();
      bmpLeft = cellFullLeftData;
      bmpCenter = cellFullCenterData;
      bmpRight = cellFullRightData;
    }

    override public function draw() : void {
      var local1:Graphics = null;
      local1 = l.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpLeft);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      l.x = 0;
      l.y = 0;
      local1 = c.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpCenter);
      local1.drawRect(0,0,_width - 10,20);
      local1.endFill();
      c.x = 5;
      c.y = 0;
      local1 = r.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpRight);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      r.x = _width - 5;
      r.y = 0;
    }
  }
}
