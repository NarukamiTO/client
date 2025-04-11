package controls.resultassets {
  import assets.resultwindow.items_mini_CENTER;
  import assets.resultwindow.items_mini_LEFT;
  import assets.resultwindow.items_mini_RIGHT;
  import controls.cellrenderer.ButtonState;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class WhiteFrame extends ButtonState {
    public var bmpLeftSmall:BitmapData;
    public var bmpRightSmall:BitmapData;

    public function WhiteFrame() {
      super();
      bmpLeft = new items_mini_LEFT(1,1);
      bmpCenter = new items_mini_CENTER(1,1);
      bmpRight = new items_mini_RIGHT(1,1);
      this.bmpLeftSmall = new BitmapData(10,40);
      this.bmpRightSmall = new BitmapData(10,40);
      this.bmpLeftSmall.copyPixels(bmpLeft,new Rectangle(0,0,10,40),new Point());
      this.bmpRightSmall.copyPixels(bmpRight,new Rectangle(10,0,10,40),new Point());
    }

    override public function draw() : void {
      var local1:Graphics = null;
      if(_width >= 40) {
        local1 = l.graphics;
        local1.clear();
        local1.beginBitmapFill(bmpLeft);
        local1.drawRect(0,0,20,40);
        local1.endFill();
        l.x = 0;
        l.y = 0;
        local1 = c.graphics;
        local1.clear();
        local1.beginBitmapFill(bmpCenter);
        local1.drawRect(0,0,_width - 40,40);
        local1.endFill();
        c.x = 20;
        c.y = 0;
        local1 = r.graphics;
        local1.clear();
        local1.beginBitmapFill(bmpRight);
        local1.drawRect(0,0,20,40);
        local1.endFill();
        r.x = _width - 20;
        r.y = 0;
      } else {
        local1 = l.graphics;
        local1.clear();
        local1.beginBitmapFill(this.bmpLeftSmall);
        local1.drawRect(0,0,10,40);
        local1.endFill();
        l.x = 0;
        l.y = 0;
        local1 = c.graphics;
        local1.clear();
        local1.beginBitmapFill(bmpCenter);
        local1.drawRect(0,0,_width - 20,40);
        local1.endFill();
        c.x = 10;
        c.y = 0;
        local1 = r.graphics;
        local1.clear();
        local1.beginBitmapFill(this.bmpRightSmall);
        local1.drawRect(0,0,10,40);
        local1.endFill();
        r.x = _width - 10;
        r.y = 0;
      }
    }
  }
}
