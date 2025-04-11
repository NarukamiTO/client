package controls.cellrenderer {
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class ButtonState extends Sprite {
    public const l:Shape = new Shape();
    public const c:Shape = new Shape();
    public const r:Shape = new Shape();

    public var bmpLeft:BitmapData = new BitmapData(1,1);
    public var bmpCenter:BitmapData = new BitmapData(1,1);
    public var bmpRight:BitmapData = new BitmapData(1,1);
    public var _width:int;

    public function ButtonState() {
      super();
      addChild(this.l);
      addChild(this.c);
      addChild(this.r);
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.draw();
    }

    public function draw() : void {
      var local1:Graphics = null;
      local1 = this.l.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpLeft);
      local1.drawRect(0,0,7,30);
      local1.endFill();
      this.l.x = 0;
      this.l.y = 0;
      local1 = this.c.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpCenter);
      local1.drawRect(0,0,this._width - 14,30);
      local1.endFill();
      this.c.x = 7;
      this.c.y = 0;
      local1 = this.r.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpRight);
      local1.drawRect(0,0,7,30);
      local1.endFill();
      this.r.x = this._width - 7;
      this.r.y = 0;
    }
  }
}
