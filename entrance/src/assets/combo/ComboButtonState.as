package assets.combo {
  import controls.ButtonState;
  import flash.display.Graphics;

  public class ComboButtonState extends ButtonState {
    public function ComboButtonState() {
      super();
    }

    override public function draw() : void {
      var local1:Graphics = null;
      local1 = l.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpLeft);
      local1.drawRect(0,0,7,30);
      local1.endFill();
      l.x = 0;
      l.y = 0;
      local1 = c.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpCenter);
      local1.drawRect(0,0,_width - 40,30);
      local1.endFill();
      c.x = 7;
      c.y = 0;
      local1 = r.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpRight);
      local1.drawRect(0,0,33,30);
      local1.endFill();
      r.x = _width - 33;
      r.y = 0;
    }
  }
}
