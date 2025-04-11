package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import assets.window.bitmaps.WindowBGTile;
  import assets.window.bitmaps.WindowBottom;
  import assets.window.bitmaps.WindowLeft;
  import assets.window.bitmaps.WindowRight;
  import assets.window.bitmaps.WindowTop;
  import assets.window.elemets.WindowBottomLeftCorner;
  import assets.window.elemets.WindowBottomRightCorner;
  import assets.window.elemets.WindowTopLeftCorner;
  import assets.window.elemets.WindowTopRightCorner;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class TankWindow extends Sprite {
    private var _width:int;
    private var _height:int;
    private var tl:WindowTopLeftCorner = new WindowTopLeftCorner();
    private var tr:WindowTopRightCorner = new WindowTopRightCorner();
    private var bl:WindowBottomLeftCorner = new WindowBottomLeftCorner();
    private var br:WindowBottomRightCorner = new WindowBottomRightCorner();
    private var bgBMP:WindowBGTile = new WindowBGTile(0,0);
    private var topBMP:WindowTop = new WindowTop(0,0);
    private var bottomBMP:WindowBottom = new WindowBottom(0,0);
    private var leftBMP:WindowLeft = new WindowLeft(0,0);
    private var rightBMP:WindowRight = new WindowRight(0,0);
    private var bg:Shape = new Shape();
    private var top:Shape = new Shape();
    private var bottom:Shape = new Shape();
    private var left:Shape = new Shape();
    private var right:Shape = new Shape();

    public function TankWindow(width:int = -1, height:int = -1) {
      super();
      this._width = width;
      this._height = height;
      this.ConfigUI();
      this.draw();
    }

    override public function set width(w:Number) : void {
      this._width = int(w);
      this.draw();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set height(h:Number) : void {
      this._height = int(h);
      this.draw();
    }

    override public function get height() : Number {
      return this._height;
    }

    private function ConfigUI() : void {
      this._width = this._width == -1 ? int(scaleX * 100) : this._width;
      this._height = this._height == -1 ? int(scaleY * 100) : this._height;
      scaleX = 1;
      scaleY = 1;
      addChild(this.bg);
      addChild(this.top);
      addChild(this.bottom);
      addChild(this.left);
      addChild(this.right);
      addChild(this.tl);
      addChild(this.tr);
      addChild(this.bl);
      addChild(this.br);
    }

    private function draw() : void {
      this.bg.graphics.clear();
      this.bg.graphics.beginBitmapFill(this.bgBMP);
      this.bg.graphics.drawRect(7,7,this._width - 14,this._height - 14);
      this.bg.graphics.endFill();
      this.top.graphics.clear();
      this.top.graphics.beginBitmapFill(this.topBMP);
      this.top.graphics.drawRect(0,0,this._width - 22,11);
      this.top.graphics.endFill();
      this.top.x = 11;
      this.bottom.graphics.clear();
      this.bottom.graphics.beginBitmapFill(this.bottomBMP);
      this.bottom.graphics.drawRect(0,0,this._width - 22,11);
      this.bottom.graphics.endFill();
      this.bottom.x = 11;
      this.bottom.y = this._height - 11;
      this.left.graphics.clear();
      this.left.graphics.beginBitmapFill(this.leftBMP);
      this.left.graphics.drawRect(0,0,11,this._height - 22);
      this.left.graphics.endFill();
      this.left.x = 0;
      this.left.y = 11;
      this.right.graphics.clear();
      this.right.graphics.beginBitmapFill(this.rightBMP);
      this.right.graphics.drawRect(0,0,11,this._height - 22);
      this.right.graphics.endFill();
      this.right.x = this._width - 11;
      this.right.y = 11;
      this.tl.x = 0;
      this.tl.y = 0;
      this.tr.x = this._width - this.tr.width;
      this.tr.y = 0;
      this.bl.x = 0;
      this.bl.y = this._height - this.bl.height;
      this.br.x = this._width - this.br.width;
      this.br.y = this._height - this.br.height;
    }
  }
}
