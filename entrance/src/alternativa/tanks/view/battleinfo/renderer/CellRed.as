package alternativa.tanks.view.battleinfo.renderer {
  import controls.cellrenderer.ButtonState;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;

  public class CellRed extends ButtonState {
    private static const cellRedLeft:Class = CellRed_cellRedLeft;
    private static const cellRedLeftData:BitmapData = Bitmap(new cellRedLeft()).bitmapData;
    private static const cellRedCenter:Class = CellRed_cellRedCenter;
    private static const cellRedCentreData:BitmapData = Bitmap(new cellRedCenter()).bitmapData;
    private static const cellRedRight:Class = CellRed_cellRedRight;
    private static const cellRedRightData:BitmapData = Bitmap(new cellRedRight()).bitmapData;

    public function CellRed() {
      super();
      bmpLeft = cellRedLeftData;
      bmpCenter = cellRedCentreData;
      bmpRight = cellRedRightData;
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
