package controls.resultassets {
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.Matrix;

  public class ResultWindowBase extends Sprite {
    protected var tl:BitmapData;
    protected var px:BitmapData;
    protected var _width:int = 10;
    protected var _height:int = 10;

    public function ResultWindowBase() {
      super();
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set height(param1:Number) : void {
      this._height = Math.floor(param1);
      this.draw();
    }

    override public function get height() : Number {
      return this._height;
    }

    protected function draw() : void {
      var local2:Matrix = null;
      var local1:Graphics = this.graphics;
      local1.clear();
      local1.beginBitmapFill(this.tl);
      local1.drawRect(0,0,4,4);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI * 0.5);
      local2.translate(this._width - 4,0);
      local1.beginBitmapFill(this.tl,local2);
      local1.drawRect(this._width - 4,0,4,4);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI);
      local2.translate(this._width - 4,this._height - 4);
      local1.beginBitmapFill(this.tl,local2);
      local1.drawRect(this._width - 4,this._height - 4,4,4);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI * 1.5);
      local2.translate(0,this._height - 4);
      local1.beginBitmapFill(this.tl,local2);
      local1.drawRect(0,this._height - 4,4,4);
      local1.endFill();
      local1.beginBitmapFill(this.px);
      local1.drawRect(4,0,this._width - 8,this._height);
      local1.drawRect(0,4,4,this._height - 8);
      local1.drawRect(this._width - 4,4,4,this._height - 8);
      local1.endFill();
    }
  }
}
