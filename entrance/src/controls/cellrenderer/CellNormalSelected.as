package controls.cellrenderer {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;

  public class CellNormalSelected extends CellRendererDefault {
    private static const normalLeft:Class = CellNormalSelected_normalLeft;
    private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
    private static const normalCenter:Class = CellNormalSelected_normalCenter;
    private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
    private static const normalRight:Class = CellNormalSelected_normalRight;
    private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;

    public function CellNormalSelected() {
      super();
      bmpLeft = normalLeftData;
      bmpCenter = normalCenterData;
      bmpRight = normalRightData;
    }

    override public function draw() : void {
      var local1:Graphics = null;
      local1 = l.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpLeft);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      l.x = 0;
      l.y = 1;
      local1 = c.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpCenter);
      local1.drawRect(0,0,_width - 10,20);
      local1.endFill();
      c.x = 5;
      c.y = 1;
      local1 = r.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpRight);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      r.x = _width - 5;
      r.y = 1;
    }
  }
}
