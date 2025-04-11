package controls {
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.text.GridFitType;
  import flash.text.TextFieldType;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;
  import forms.events.LoginFormEvent;

  public class NumStepper extends MovieClip {
    private const CHANGE_COUNTER_VALUE:int = 7;
    private const DEFAULT_INTERVAL_DURATION_MS:int = 75;
    private const TIMER_DELAY_MS:int = 500;
    private const STEPS:Vector.<int> = new <int>[1,5,10,20,50,100,200,500];

    private var tf:TankInputBase = new TankInputBase();
    private var button:StepperButton = new StepperButton();
    private var _value:int = 0;
    private var _maxValue:int = 10;
    private var _minValue:int = 0;
    private var _label:LabelBase;
    private var _step:int = 1;
    private var _stepAddedByInterval:int = 1;
    private var _intervalId:uint;
    private var _intervalCounter:int = 0;
    private var _stepIndex:int = 0;
    private var _timer:Timer;
    private var _enable:Boolean = true;
    private var _icon:DisplayObject;

    public function NumStepper() {
      super();
      this.tf.width = 55;
      this.tf.x = 19;
      this.tf.restrict = "0-9";
      this.tf.maxChars = 5;
      this.tf.align = TextFormatAlign.CENTER;
      this.tf.textField.addEventListener(FocusEvent.FOCUS_OUT,this.onTextChange);
      this.tf.textField.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onTextChange);
      this.tf.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onTextChange);
      this.tf.textField.addEventListener(FocusEvent.FOCUS_IN,this.clearTF);
      addChild(this.tf);
      this.button.x = 75;
      addChild(this.button);
      this._timer = new Timer(this.TIMER_DELAY_MS,1);
      this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
      this.draw();
      this.enabled = true;
    }

    public function set minValue(param1:int) : void {
      this._minValue = param1;
      this._value = Math.max(this._value,this._minValue);
      this.draw();
    }

    public function set maxValue(param1:int) : void {
      this._maxValue = param1;
      this._value = Math.min(this._value,this._maxValue);
      this.draw();
    }

    public function set icon(param1:DisplayObject) : void {
      if(this._icon != null) {
        removeChildAt(0);
      }
      this._icon = param1;
      addChildAt(this._icon,0);
      this._icon.y = 8;
    }

    public function set label(param1:String) : void {
      if(this._label == null) {
        this._label = new LabelBase();
        this._label.x = 18;
        this._label.y = -18;
        this._label.gridFitType = GridFitType.SUBPIXEL;
        addChild(this._label);
      }
      this._label.text = param1;
    }

    public function get value() : int {
      return this._value;
    }

    public function set value(param1:int) : void {
      this._value = param1;
      this.draw();
    }

    private function onTimerComplete(param1:TimerEvent) : void {
      this._intervalId = setInterval(this.changeCounterByTime,this.DEFAULT_INTERVAL_DURATION_MS);
    }

    private function changeCounterByTime() : void {
      stage.focus = this.button;
      this.button.gotoAndStop(this.button.mouseY < 15 ? 2 : 3);
      this._value = Number(this.getTrimString(this.tf.value));
      this._value += this.button.mouseY <= 15 ? this._stepAddedByInterval : -this._stepAddedByInterval;
      this._value = Math.max(Math.min(this._value,this._maxValue),this._minValue);
      this.draw();
      ++this._intervalCounter;
      if(this._intervalCounter >= this.CHANGE_COUNTER_VALUE) {
        if(this._stepIndex + 1 < this.STEPS.length) {
          if(this._value % this.getStepByIndex(this._stepIndex + 1) < this._step) {
            this._intervalCounter = 0;
            this._stepAddedByInterval = this.getStepByIndex(this._stepIndex + 1);
            ++this._stepIndex;
          }
        }
      }
    }

    override public function set enabled(param1:Boolean) : void {
      this._enable = param1;
      if(this._enable) {
        this.button.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
        this.button.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        this.button.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp);
        this.tf.textField.selectable = true;
        this.tf.textField.type = TextFieldType.INPUT;
      } else {
        this.button.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
        this.button.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        this.button.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp);
        this.tf.textField.selectable = false;
        this.tf.textField.type = TextFieldType.DYNAMIC;
      }
      mouseEnabled = param1;
      mouseChildren = param1;
    }

    private function clearTF(param1:Event) : void {
      if(this.tf.value == "—") {
        this.tf.clear();
      }
    }

    private function onTextChange(param1:Event) : void {
      var local2:int = Number(this.getTrimString(this.tf.value));
      this._value = Math.max(this._minValue,Math.min(local2,this._maxValue));
      this.draw();
    }

    protected function onMouseDown(param1:MouseEvent) : void {
      stage.focus = this.button;
      this.button.gotoAndStop(this.button.mouseY < 15 ? 2 : 3);
      this._value = Number(this.getTrimString(this.tf.value));
      this._value = Math.min(this._value,this._maxValue);
      var local2:int = this._value + (this.button.mouseY > 15 ? -this._step : this._step);
      this._value = Math.max(this._minValue,Math.min(local2,this._maxValue));
      this._timer.reset();
      this._timer.start();
      this.draw();
    }

    private function onMouseUp(param1:MouseEvent) : void {
      this.button.gotoAndStop(1);
      this._timer.stop();
      clearInterval(this._intervalId);
      this._intervalCounter = 0;
      this._stepAddedByInterval = this.getStepByIndex(0);
      this._stepIndex = 0;
    }

    protected function draw() : void {
      var local1:String = this.tf.value;
      if(stage != null) {
        this.tf.value = this._value > 0 || stage.focus == this.tf.textField ? Money.numToString(this.value,false) : "—";
        if(this._enable && local1 != this.tf.value) {
          dispatchEvent(new Event(Event.CHANGE));
        }
      } else {
        this.tf.value = this._value > 0 ? Money.numToString(this.value,false) : "—";
      }
    }

    private function getTrimString(param1:String) : String {
      return param1.replace(" ","");
    }

    public function set step(param1:int) : void {
      this._step = param1;
    }

    public function getStepByIndex(param1:int) : int {
      return this.STEPS[param1] * this._step;
    }
  }
}
