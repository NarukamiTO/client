package controls.cellrenderer {
  import flash.display.Graphics;

  public class CellRendererDefault extends ButtonState {
    public function CellRendererDefault() {
      super();
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
