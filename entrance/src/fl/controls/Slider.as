package fl.controls {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.InteractionInputType;
  import fl.events.SliderEvent;
  import fl.events.SliderEventClickTarget;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;

  [Style(name="tickSkin",type="Class")]
  [Style(name="sliderTrackDisabledSkin",type="Class")]
  [Style(name="sliderTrackSkin",type="Class")]
  [Style(name="thumbDisabledSkin",type="Class")]
  [Style(name="thumbDownSkin",type="Class")]
  [Style(name="thumbOverSkin",type="Class")]
  [Style(name="thumbUpSkin",type="Class")]
  [Event(name="change",type="fl.events.SliderEvent")]
  [Event(name="thumbDrag",type="fl.events.SliderEvent")]
  [Event(name="thumbRelease",type="fl.events.SliderEvent")]
  [Event(name="thumbPress",type="fl.events.SliderEvent")]
  [Embed(source="/_assets/assets.swf", symbol="symbol1177")]
  public class Slider extends UIComponent implements IFocusManagerComponent {
    protected static var defaultStyles:Object = {
      "thumbUpSkin":"SliderThumb_upSkin",
      "thumbOverSkin":"SliderThumb_overSkin",
      "thumbDownSkin":"SliderThumb_downSkin",
      "thumbDisabledSkin":"SliderThumb_disabledSkin",
      "sliderTrackSkin":"SliderTrack_skin",
      "sliderTrackDisabledSkin":"SliderTrack_disabledSkin",
      "tickSkin":"SliderTick_skin",
      "focusRectSkin":null,
      "focusRectPadding":null
    };

    protected static const TRACK_STYLES:Object = {
      "upSkin":"sliderTrackSkin",
      "overSkin":"sliderTrackSkin",
      "downSkin":"sliderTrackSkin",
      "disabledSkin":"sliderTrackDisabledSkin"
    };

    protected static const THUMB_STYLES:Object = {
      "upSkin":"thumbUpSkin",
      "overSkin":"thumbOverSkin",
      "downSkin":"thumbDownSkin",
      "disabledSkin":"thumbDisabledSkin"
    };

    protected static const TICK_STYLES:Object = {"upSkin":"tickSkin"};

    protected var _direction:String = SliderDirection.HORIZONTAL;
    protected var _snapInterval:Number = 0;
    protected var _liveDragging:Boolean = false;
    protected var track:BaseButton;
    protected var _minimum:Number = 0;
    protected var thumb:BaseButton;
    protected var _maximum:Number = 10;
    protected var _tickInterval:Number = 0;
    protected var tickContainer:Sprite;
    protected var _value:Number = 0;

    public function Slider() {
      super();
      setStyles();
    }

    public static function getStyleDefinition() : Object {
      return defaultStyles;
    }

    [Inspectable(defaultValue="0")]
    public function get tickInterval() : Number {
      return _tickInterval;
    }

    override public function setSize(param1:Number, param2:Number) : void {
      if(_direction == SliderDirection.VERTICAL && !isLivePreview) {
        super.setSize(param2,param1);
      } else {
        super.setSize(param1,param2);
      }
      invalidate(InvalidationType.SIZE);
    }

    public function set tickInterval(param1:Number) : void {
      _tickInterval = param1;
      invalidate(InvalidationType.SIZE);
    }

    override public function set enabled(param1:Boolean) : void {
      if(enabled == param1) {
        return;
      }
      super.enabled = param1;
      track.enabled = thumb.enabled = param1;
    }

    protected function drawTicks() : void {
      var local5:DisplayObject = null;
      clearTicks();
      tickContainer = new Sprite();
      var local1:Number = maximum < 1 ? tickInterval / 100 : tickInterval;
      var local2:Number = (maximum - minimum) / local1;
      var local3:Number = _width / local2;
      var local4:uint = 0;
      while(local4 <= local2) {
        local5 = getDisplayObjectInstance(getStyleValue("tickSkin"));
        local5.x = local3 * local4;
        local5.y = track.y - local5.height - 2;
        tickContainer.addChild(local5);
        local4++;
      }
      addChild(tickContainer);
    }

    [Inspectable(defaultValue="10")]
    public function get maximum() : Number {
      return _maximum;
    }

    public function set minimum(param1:Number) : void {
      _minimum = param1;
      this.value = Math.max(param1,this.value);
      invalidate(InvalidationType.DATA);
    }

    [Inspectable(defaultValue="0")]
    public function get minimum() : Number {
      return _minimum;
    }

    protected function clearTicks() : void {
      if(!tickContainer || !tickContainer.parent) {
        return;
      }
      removeChild(tickContainer);
    }

    protected function calculateValue(param1:Number, param2:String, param3:String, param4:int = undefined) : void {
      var local5:Number = param1 / _width * (maximum - minimum);
      if(_direction == SliderDirection.VERTICAL) {
        local5 = maximum - local5;
      } else {
        local5 = minimum + local5;
      }
      doSetValue(local5,param2,param3,param4);
    }

    protected function positionThumb() : void {
      thumb.x = (_direction == SliderDirection.VERTICAL ? maximum - value : value - minimum) / (maximum - minimum) * _width;
    }

    [Inspectable(defaultValue="0")]
    public function get snapInterval() : Number {
      return _snapInterval;
    }

    [Inspectable(defaultValue="false")]
    public function set liveDragging(param1:Boolean) : void {
      _liveDragging = param1;
    }

    protected function thumbReleaseHandler(param1:MouseEvent) : void {
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
      stage.removeEventListener(MouseEvent.MOUSE_UP,thumbReleaseHandler);
      dispatchEvent(new SliderEvent(SliderEvent.THUMB_RELEASE,value,SliderEventClickTarget.THUMB,InteractionInputType.MOUSE));
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE,value,SliderEventClickTarget.THUMB,InteractionInputType.MOUSE));
    }

    protected function onTrackClick(param1:MouseEvent) : void {
      calculateValue(track.mouseX,InteractionInputType.MOUSE,SliderEventClickTarget.TRACK);
      if(!liveDragging) {
        dispatchEvent(new SliderEvent(SliderEvent.CHANGE,value,SliderEventClickTarget.TRACK,InteractionInputType.MOUSE));
      }
    }

    public function set maximum(param1:Number) : void {
      _maximum = param1;
      this.value = Math.min(param1,this.value);
      invalidate(InvalidationType.DATA);
    }

    [Inspectable(defaultValue="true",verbose="1")]
    override public function get enabled() : Boolean {
      return super.enabled;
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.STYLES)) {
        setStyles();
        invalidate(InvalidationType.SIZE,false);
      }
      if(isInvalid(InvalidationType.SIZE)) {
        track.setSize(_width,track.height);
        track.drawNow();
        thumb.drawNow();
      }
      if(tickInterval > 0) {
        drawTicks();
      } else {
        clearTicks();
      }
      positionThumb();
      super.draw();
    }

    protected function getPrecision(param1:Number) : Number {
      var local2:String = param1.toString();
      if(local2.indexOf(".") == -1) {
        return 0;
      }
      return local2.split(".").pop().length;
    }

    protected function doSetValue(param1:Number, param2:String = null, param3:String = null, param4:int = undefined) : void {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local5:Number = _value;
      if(_snapInterval != 0 && _snapInterval != 1) {
        local6 = Math.pow(10,getPrecision(snapInterval));
        local7 = _snapInterval * local6;
        local8 = Math.round(param1 * local6);
        local9 = Math.round(local8 / local7) * local7;
        param1 = local9 / local6;
        _value = Math.max(minimum,Math.min(maximum,param1));
      } else {
        _value = Math.max(minimum,Math.min(maximum,Math.round(param1)));
      }
      if(local5 != _value && (liveDragging && param3 != null || param2 == InteractionInputType.KEYBOARD)) {
        dispatchEvent(new SliderEvent(SliderEvent.CHANGE,value,param3,param2,param4));
      }
      positionThumb();
    }

    public function get liveDragging() : Boolean {
      return _liveDragging;
    }

    override protected function configUI() : void {
      super.configUI();
      thumb = new BaseButton();
      thumb.setSize(13,13);
      thumb.autoRepeat = false;
      addChild(thumb);
      thumb.addEventListener(MouseEvent.MOUSE_DOWN,thumbPressHandler,false,0,true);
      track = new BaseButton();
      track.move(0,0);
      track.setSize(80,4);
      track.autoRepeat = false;
      track.useHandCursor = false;
      track.addEventListener(MouseEvent.CLICK,onTrackClick,false,0,true);
      addChildAt(track,0);
    }

    public function set snapInterval(param1:Number) : void {
      _snapInterval = param1;
    }

    protected function doDrag(param1:MouseEvent) : void {
      var local2:Number = _width / snapInterval;
      var local3:Number = track.mouseX;
      calculateValue(local3,InteractionInputType.MOUSE,SliderEventClickTarget.THUMB);
      dispatchEvent(new SliderEvent(SliderEvent.THUMB_DRAG,value,SliderEventClickTarget.THUMB,InteractionInputType.MOUSE));
    }

    public function set value(param1:Number) : void {
      doSetValue(param1);
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      var local3:Number = NaN;
      if(!enabled) {
        return;
      }
      var local2:Number = snapInterval > 0 ? snapInterval : 1;
      var local4:Boolean = direction == SliderDirection.HORIZONTAL;
      if(param1.keyCode == Keyboard.DOWN && !local4 || param1.keyCode == Keyboard.LEFT && local4) {
        local3 = value - local2;
      } else if(param1.keyCode == Keyboard.UP && !local4 || param1.keyCode == Keyboard.RIGHT && local4) {
        local3 = value + local2;
      } else if(param1.keyCode == Keyboard.PAGE_DOWN && !local4 || param1.keyCode == Keyboard.HOME && local4) {
        local3 = minimum;
      } else if(param1.keyCode == Keyboard.PAGE_UP && !local4 || param1.keyCode == Keyboard.END && local4) {
        local3 = maximum;
      }
      if(!isNaN(local3)) {
        param1.stopPropagation();
        doSetValue(local3,InteractionInputType.KEYBOARD,null,param1.keyCode);
      }
    }

    [Inspectable(defaultValue="0")]
    public function get value() : Number {
      return _value;
    }

    protected function setStyles() : void {
      copyStylesToChild(thumb,THUMB_STYLES);
      copyStylesToChild(track,TRACK_STYLES);
    }

    protected function thumbPressHandler(param1:MouseEvent) : void {
      stage.addEventListener(MouseEvent.MOUSE_MOVE,doDrag,false,0,true);
      stage.addEventListener(MouseEvent.MOUSE_UP,thumbReleaseHandler,false,0,true);
      dispatchEvent(new SliderEvent(SliderEvent.THUMB_PRESS,value,SliderEventClickTarget.THUMB,InteractionInputType.MOUSE));
    }

    public function set direction(param1:String) : void {
      _direction = param1;
      var local2:Boolean = _direction == SliderDirection.VERTICAL;
      if(isLivePreview) {
        if(local2) {
          setScaleY(-1);
          y = track.height;
        } else {
          setScaleY(1);
          y = 0;
        }
        positionThumb();
        return;
      }
      if(local2 && componentInspectorSetting) {
        if(rotation % 90 == 0) {
          setScaleY(-1);
        }
      }
      if(!componentInspectorSetting) {
        rotation = local2 ? 90 : 0;
      }
    }

    [Inspectable(enumeration="horizontal,vertical",defaultValue="horizontal")]
    public function get direction() : String {
      return _direction;
    }
  }
}
