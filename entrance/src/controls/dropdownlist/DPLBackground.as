package controls.dropdownlist {
  import assets.windowinner.bitmaps.WindowInnerBottom;
  import assets.windowinner.bitmaps.WindowInnerLeft;
  import assets.windowinner.bitmaps.WindowInnerRight;
  import assets.windowinner.bitmaps.WindowInnerTop;
  import assets.windowinner.elemets.WindowInnerBottomLeftCorner;
  import assets.windowinner.elemets.WindowInnerBottomRightCorner;
  import assets.windowinner.elemets.WindowInnerTopLeftCorner;
  import assets.windowinner.elemets.WindowInnerTopRightCorner;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class DPLBackground extends Sprite {
    protected static var _bgBMP:BitmapData;

    private static const bitmapBG:Class = DPLBackground_bitmapBG;

    private var _width:int = 0;
    private var _height:int = 0;
    private var tl:WindowInnerTopLeftCorner = new WindowInnerTopLeftCorner();
    private var tr:WindowInnerTopRightCorner = new WindowInnerTopRightCorner();
    private var bl:WindowInnerBottomLeftCorner = new WindowInnerBottomLeftCorner();
    private var br:WindowInnerBottomRightCorner = new WindowInnerBottomRightCorner();
    private var topBMP:WindowInnerTop = new WindowInnerTop(0,0);
    private var bottomBMP:WindowInnerBottom = new WindowInnerBottom(0,0);
    private var leftBMP:WindowInnerLeft = new WindowInnerLeft(0,0);
    private var rightBMP:WindowInnerRight = new WindowInnerRight(0,0);
    private var bg:Sprite = new Sprite();
    private var top:Shape = new Shape();
    private var bottom:Shape = new Shape();
    private var left:Shape = new Shape();
    private var right:Shape = new Shape();

    public function DPLBackground(param1:int, param2:int) {
      super();
      this._width = param1;
      this._height = param2;
      addChild(this.bg);
      addChild(this.top);
      addChild(this.bottom);
      addChild(this.left);
      addChild(this.right);
      addChild(this.tl);
      addChild(this.tr);
      addChild(this.bl);
      addChild(this.br);
      this.draw();
    }

    protected function get bgBMP() : BitmapData {
      if(!_bgBMP) {
        _bgBMP = new bitmapBG().bitmapData;
      }
      return _bgBMP;
    }

    protected function draw() : void {
      var local1:Graphics = null;
      local1 = this.bg.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bgBMP);
      local1.drawRect(1,1,this._width - 2,this._height - 2);
      local1.endFill();
      local1 = this.top.graphics;
      local1.clear();
      local1.beginBitmapFill(this.topBMP);
      local1.drawRect(0,0,this._width - 12,6);
      local1.endFill();
      this.top.x = 6;
      local1 = this.bottom.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bottomBMP);
      local1.drawRect(0,0,this._width - 12,6);
      local1.endFill();
      this.bottom.x = 6;
      this.bottom.y = this._height - 6;
      local1 = this.left.graphics;
      local1.clear();
      local1.beginBitmapFill(this.leftBMP);
      local1.drawRect(0,0,6,this._height - 12);
      local1.endFill();
      this.left.x = 0;
      this.left.y = 6;
      local1 = this.right.graphics;
      local1.clear();
      local1.beginBitmapFill(this.rightBMP);
      local1.drawRect(0,0,6,this._height - 12);
      local1.endFill();
      this.right.x = this._width - 6;
      this.right.y = 6;
      this.tl.x = 0;
      this.tl.y = 0;
      this.tr.x = this._width - this.tr.width;
      this.tr.y = 0;
      this.bl.x = 0;
      this.bl.y = this._height - this.bl.height;
      this.br.x = this._width - this.br.width;
      this.br.y = this._height - this.br.height;
    }

    override public function set width(param1:Number) : void {
      if(this._width == int(param1)) {
        return;
      }
      this._width = param1;
      this.draw();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set height(param1:Number) : void {
      if(this._height == int(param1)) {
        return;
      }
      this._height = param1;
      this.draw();
    }

    override public function get height() : Number {
      return this._height;
    }

    public function setSize(param1:int, param2:int) : void {
      this._width = param1;
      this._height = param2;
      this.draw();
    }
  }
}
