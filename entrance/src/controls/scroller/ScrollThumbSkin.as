package controls.scroller {
  import flash.display.BitmapData;
  import flash.display.MovieClip;
  import flash.display.Shape;

  public class ScrollThumbSkin extends MovieClip {
    public static const _width:Number = 14;

    private var _height:Number = 30;

    public var toppng:BitmapData;
    public var midpng:BitmapData;

    private var top:Shape = new Shape();
    private var bottom:Shape = new Shape();

    public function ScrollThumbSkin() {
      super();
      this.initSkin();
      this.top.graphics.clear();
      this.top.graphics.beginBitmapFill(this.toppng);
      this.top.graphics.drawRect(0,0,_width,1);
      this.top.graphics.endFill();
      this.bottom.graphics.clear();
      this.bottom.graphics.beginBitmapFill(this.toppng);
      this.bottom.graphics.drawRect(0,0,_width,1);
      this.bottom.graphics.endFill();
      addChild(this.top);
      addChild(this.bottom);
      this.top.y = -12;
    }

    public function initSkin() : void {
    }

    override public function set height(param1:Number) : void {
      this._height = int(param1);
      this.draw();
    }

    override public function set y(param1:Number) : void {
      super.y = int(param1);
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set width(param1:Number) : void {
      this.draw();
    }

    override public function get width() : Number {
      return _width;
    }

    private function draw() : void {
      this.bottom.y = this._height + 11;
      graphics.clear();
      graphics.beginBitmapFill(this.midpng);
      graphics.drawRect(0,-11,_width,this._height + 22);
      graphics.endFill();
    }
  }
}
