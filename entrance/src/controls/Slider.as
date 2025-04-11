package controls {
  import controls.slider.SliderThumb;
  import controls.slider.SliderTrack;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.events.SliderEvent;

  public class Slider extends Sprite {
    protected var track:SliderTrack = new SliderTrack();
    protected var thumb:SliderThumb = new SliderThumb();
    protected var _thumb_width:int = 30;
    protected var curThumbX:int;
    protected var trgt:Sprite;

    public var _width:int;

    protected var _minValue:Number = 0;
    protected var _maxValue:Number = 100;
    protected var _value:Number = 0;
    protected var _tick:Number = 10;

    public function Slider() {
      super();
      addChild(this.track);
      addChild(this.thumb);
      this.thumb.width = this._thumb_width;
      addEventListener(Event.ADDED_TO_STAGE,this.ConfigUI);
      addEventListener(Event.REMOVED_FROM_STAGE,this.UnConfigUI);
    }

    protected function UnConfigUI(param1:Event) : void {
      stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragThumb);
    }

    protected function ConfigUI(param1:Event) : void {
      this.thumb.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
    }

    protected function onMouseDown(param1:MouseEvent) : void {
      this.trgt = Sprite(param1.currentTarget);
      stage.addEventListener(MouseEvent.MOUSE_MOVE,this.dragThumb);
      this.curThumbX = this.trgt.mouseX;
    }

    protected function onMouseUp(param1:MouseEvent) : void {
      if(param1 != null) {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragThumb);
      }
      this.trgt = null;
    }

    protected function dragThumb(param1:MouseEvent) : void {
      var local2:Number = NaN;
      this.thumb.x += this.thumb.mouseX - this.curThumbX;
      if(this.thumb.x < 0) {
        this.thumb.x = 0;
      }
      if(this.thumb.x > this._width - this._thumb_width) {
        this.thumb.x = this._width - this._thumb_width;
      }
      local2 = this._minValue + this.thumb.x * (this._maxValue - this._minValue) / (width - this._thumb_width);
      this._value = local2;
      dispatchEvent(new SliderEvent(local2));
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.track.width = this._width;
    }

    public function get minValue() : Number {
      return this._minValue;
    }

    public function set minValue(param1:Number) : void {
      this._minValue = param1;
      this.track.minValue = this._minValue;
    }

    public function get maxValue() : Number {
      return this._maxValue;
    }

    public function set maxValue(param1:Number) : void {
      this._maxValue = param1;
      this.track.maxValue = this._maxValue;
    }

    public function get value() : Number {
      return this._value;
    }

    public function set value(param1:Number) : void {
      this._value = param1;
      this.setThumb();
    }

    public function set tickInterval(param1:Number) : void {
      this._tick = param1;
      this.track.tickInterval = this._tick;
    }

    protected function setThumb() : void {
      this.thumb.x = int((this._value - this._minValue) * (this._width - this._thumb_width) / (this._maxValue - this._minValue));
    }
  }
}
