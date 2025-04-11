package controls.slider {
  import assets.slider.slider_TRACK_CENTER;
  import assets.slider.slider_TRACK_LEFT;
  import assets.slider.slider_TRACK_RIGHT;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.Matrix;

  public class SliderTrack extends Sprite {
    protected var track_bmpLeft:slider_TRACK_LEFT = new slider_TRACK_LEFT(1,1);
    protected var track_bmpCenter:slider_TRACK_CENTER = new slider_TRACK_CENTER(1,1);
    protected var track_bmpRight:slider_TRACK_RIGHT = new slider_TRACK_RIGHT(1,1);
    protected var _width:int;
    protected var _showTrack:Boolean;
    protected var _minValue:Number = 0;
    protected var _maxValue:Number = 100;
    protected var _tick:Number = 10;

    public function SliderTrack(param1:Boolean = true) {
      super();
      this._showTrack = param1;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.draw();
    }

    protected function draw() : void {
      var local2:Matrix = null;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local1:Graphics = this.graphics;
      local1.clear();
      local1.beginBitmapFill(this.track_bmpLeft);
      local1.drawRect(0,0,5,30);
      local1.endFill();
      local2 = new Matrix();
      local2.translate(5,0);
      local1.beginBitmapFill(this.track_bmpCenter,local2);
      local1.drawRect(5,0,this._width - 11,30);
      local1.endFill();
      local2 = new Matrix();
      local2.translate(this._width - 6,0);
      local1.beginBitmapFill(this.track_bmpRight,local2);
      local1.drawRect(this._width - 6,0,6,30);
      local1.endFill();
      if(this._showTrack) {
        local3 = width / ((this._maxValue - this._minValue) / this._tick);
        local4 = local3;
        while(local4 < this._width) {
          local1.lineStyle(0,16777215,0.4);
          local1.moveTo(local4,5);
          local1.lineTo(local4,25);
          local4 += local3;
        }
      }
    }

    public function set minValue(param1:Number) : void {
      this._minValue = param1;
      this.draw();
    }

    public function set maxValue(param1:Number) : void {
      this._maxValue = param1;
      this.draw();
    }

    public function set tickInterval(param1:Number) : void {
      this._tick = param1;
      this.draw();
    }
  }
}
