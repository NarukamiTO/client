package controls.numeric {
  import controls.base.TankInputBase;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextFieldType;
  import flash.text.TextFormatAlign;
  import flash.ui.Keyboard;
  import mx.utils.StringUtil;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class NumericEditor extends Sprite {
    protected static const WIDTH_PER_CHAR:int = 9;

    public var tf:TankInputBase = new TankInputBase();

    protected var _value:Number = 0;

    private var _step:Number = 1;
    private var precision:int = 0;
    private var _enabled:Boolean;
    private var minValue:Number = 0;
    private var maxValue:Number = 10;
    private var isRecentFocus:Boolean;
    private var thousandsSeparator:Boolean = true;
    private var bubble:BubbleHelper = new BubbleHelper();
    private var lessMinimumMessage:String = null;
    private var greaterMaximumMessage:String = null;

    public function NumericEditor(param1:Boolean = false) {
      super();
      this.tf.restrict = "0-9";
      this.tf.maxChars = 5;
      addChild(this.tf);
      this.setWidth(55);
      if(!param1) {
        this.tf.textField.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut,false,0,true);
        this.tf.textField.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
        this.tf.textField.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,false,0,true);
        this.tf.textField.addEventListener(Event.CHANGE,this.onTextChange,false,0,true);
        this.tf.textField.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
        this.tf.textField.addEventListener(FocusEvent.FOCUS_IN,this.onFocus,false,0,true);
      } else {
        this.tf.textField.type = TextFieldType.DYNAMIC;
        this.tf.textField.selectable = false;
        this.tf.textField.mouseEnabled = false;
        this.tf.textField.mouseWheelEnabled = false;
      }
      this.tf.align = TextFormatAlign.RIGHT;
      this.enabled = true;
      this.setValue(this._value);
      this.draw();
    }

    public function setLessMinimumMessage(param1:String) : void {
      this.lessMinimumMessage = param1;
    }

    public function setGreaterMaximumMessage(param1:String) : void {
      this.greaterMaximumMessage = param1;
    }

    protected function onKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        stage.focus = null;
      }
    }

    private function onClick(param1:MouseEvent) : void {
      if(this.isRecentFocus) {
        this.isRecentFocus = false;
        this.selectAll();
      }
    }

    private function onDoubleClick(param1:MouseEvent) : void {
      this.selectAll();
    }

    private function onFocusOut(param1:Event) : void {
      this.thousandsSeparator = true;
      this.setValue(this._value,true);
      this.draw();
    }

    private function onFocus(param1:Event) : void {
      if(this.tf.value == "—") {
        this.tf.clear();
      }
      this.thousandsSeparator = false;
      this.draw();
      this.isRecentFocus = true;
    }

    private function onTextChange(param1:Event) : void {
      var local2:Number = NaN;
      if(stage == null) {
        return;
      }
      if(stage.focus == this.tf.textField) {
        local2 = Number(this.tf.value);
        if(!isNaN(local2)) {
          this._value = local2;
          this.checkValid();
        } else {
          this.tf.validValue = false;
        }
      } else {
        this.correctValue();
        this.draw();
      }
      if(this._enabled) {
        dispatchEvent(new NumericEditorEvent(NumericEditorEvent.CHANGE,this.tf.validValue,true));
      }
    }

    private function checkValid() : void {
      if(this._value < this.minValue) {
        if(this.isFocused() && this.lessMinimumMessage != null) {
          this.showBubble(StringUtil.substitute(this.lessMinimumMessage,this.valueToString(this.minValue)));
        }
        this.tf.validValue = false;
      } else if(this._value > this.maxValue) {
        if(this.isFocused() && this.greaterMaximumMessage != null) {
          this.showBubble(StringUtil.substitute(this.greaterMaximumMessage,this.valueToString(this.maxValue)));
        }
        this.tf.validValue = false;
      } else {
        this.tf.validValue = true;
        this.hideBubble();
      }
    }

    private function showBubble(param1:String) : void {
      this.bubble.text = param1;
      this.bubble.arrowLehgth = height / 2;
      this.bubble.arrowAlign = HelperAlign.TOP_LEFT;
      this.bubble.x = x + this.tf.textField.x + this.tf.textField.width - 24;
      this.bubble.y = y + height + this.bubble.arrowLehgth - 2;
      if(this.bubble.parent == null) {
        this.parent.addChild(this.bubble);
      }
      this.bubble.draw(this.bubble.size);
    }

    private function hideBubble() : void {
      if(this.bubble.parent != null) {
        this.bubble.parent.removeChild(this.bubble);
      }
    }

    private function correctValue() : void {
      this.setValue(Math.max(this.minValue,Math.min(this._value,this.maxValue)));
    }

    private function draw() : void {
      this.tf.value = this.valueToString(this._value);
      this.checkValid();
    }

    private function valueToString(param1:Number) : String {
      var local2:String = null;
      var local3:String = null;
      if(param1 > 0) {
        local2 = param1.toFixed(this.precision);
        if(this.thousandsSeparator) {
          local3 = "";
          if(this.precision > 0) {
            local3 = local2.substr(local2.length - this.precision - 1);
            local2 = local2.substr(0,local2.length - this.precision - 1);
          }
          while(local2.length > 3) {
            local3 = " " + local2.substr(local2.length - 3,3) + local3;
            local2 = local2.substr(0,local2.length - 3);
          }
          return local2 + local3;
        }
        return local2;
      }
      return "-";
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
      if(this._enabled) {
        this.tf.textField.selectable = true;
        this.tf.textField.type = TextFieldType.INPUT;
      } else {
        this.tf.textField.selectable = false;
        this.tf.textField.type = TextFieldType.DYNAMIC;
      }
    }

    public function get intValue() : int {
      return int(this._value + 0.000001);
    }

    public function setValue(param1:Number, param2:Boolean = false) : void {
      if(this.minValue > param1) {
        param1 = this.minValue;
      }
      if(this.maxValue < param1) {
        param1 = this.maxValue;
      }
      if(this._value != param1) {
        this._value = param1;
        this.draw();
        if(this._enabled) {
          dispatchEvent(new NumericEditorEvent(NumericEditorEvent.CHANGE,true,param2));
        }
      }
    }

    public function setMaxChars(param1:int) : void {
      this.tf.maxChars = param1;
      if(this.tf.width < param1 * WIDTH_PER_CHAR + 3) {
        this.setWidth(param1 * WIDTH_PER_CHAR + 3);
      }
    }

    public function getValue() : Number {
      return this._value;
    }

    public function setPrecision(param1:int) : void {
      this.precision = param1;
      if(this.precision == 0) {
        this.tf.restrict = "0-9";
      } else {
        this.tf.restrict = "0-9.";
      }
      this.draw();
    }

    public function get step() : Number {
      return this._step;
    }

    public function setStep(param1:Number) : void {
      this._step = param1;
    }

    public function setMinValue(param1:Number) : void {
      this.minValue = param1;
      this.setValue(this._value);
      this.checkValid();
    }

    public function setWidth(param1:int) : void {
      this.tf.width = param1;
      this.tf.textField.width = param1 - 10;
    }

    public function isFocused() : Boolean {
      return stage != null && stage.focus == this.tf.textField;
    }

    public function setMaxValue(param1:Number) : void {
      this.setMaxChars(Math.max(this.tf.textField.maxChars,this.valueToString(param1).length));
      this.maxValue = param1;
      this.setValue(this._value);
      this.checkValid();
    }

    public function selectAllIfFocused() : void {
      if(this.isFocused()) {
        this.selectAll();
      }
    }

    public function selectAll() : void {
      this.tf.textField.setSelection(0,this.tf.value.length);
    }

    override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = true) : void {
      super.addEventListener(param1,param2,param3,param4,param5);
    }
  }
}
