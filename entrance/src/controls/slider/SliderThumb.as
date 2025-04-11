package controls.slider {
  import assets.slider.slider_THUMB_CENTER;
  import assets.slider.slider_THUMB_LEFT;
  import assets.slider.slider_THUMB_RIGHT;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.Matrix;

  public class SliderThumb extends Sprite {
    protected var thumb_bmpLeft:slider_THUMB_LEFT = new slider_THUMB_LEFT(1,1);
    protected var thumb_bmpCenter:slider_THUMB_CENTER = new slider_THUMB_CENTER(1,1);
    protected var thumb_bmpRight:slider_THUMB_RIGHT = new slider_THUMB_RIGHT(1,1);
    protected var _width:int;

    public function SliderThumb() {
      super();
      buttonMode = true;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.draw();
    }

    protected function draw() : void {
      var local2:Matrix = null;
      var local1:Graphics = this.graphics;
      local1.clear();
      local1.beginBitmapFill(this.thumb_bmpLeft);
      local1.drawRect(0,0,10,30);
      local1.endFill();
      local2 = new Matrix();
      local2.translate(10,0);
      local1.beginBitmapFill(this.thumb_bmpCenter,local2);
      local1.drawRect(10,0,this._width - 20,30);
      local1.endFill();
      local2 = new Matrix();
      local2.translate(this._width - 10,0);
      local1.beginBitmapFill(this.thumb_bmpRight,local2);
      local1.drawRect(this._width - 10,0,10,30);
      local1.endFill();
    }
  }
}
