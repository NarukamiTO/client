package controls {
  import assets.button.button_OFF_CENTER;
  import assets.button.button_OFF_LEFT;
  import assets.button.button_OFF_RIGHT;
  import assets.input.*;
  import controls.base.LabelBase;
  import controls.base.TextFieldUtf8Base;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.TextEvent;
  import flash.events.TimerEvent;
  import flash.system.Capabilities;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import fonts.TanksFontService;
  import forms.events.LoginFormEvent;
  import utils.FontParamsUtil;

  public class TankInputL extends Sprite {
    private var _timeout:int = 0;
    private var _valide:Boolean = true;
    private var _value:String = "";

    public var _label:LabelBase;

    private const format:TextFormat = TanksFontService.getTextFormat(12);
    private const bg:Sprite = new Sprite();
    private const l:Shape = new Shape();
    private const c:Shape = new Shape();
    private const r:Shape = new Shape();
    private const bmpLeft:InputLeft = new InputLeft(0,0);
    private const bmpCenter:InputCenter = new InputCenter(0,0);
    private const bmpRight:InputRight = new InputRight(0,0);
    private const bmpLeftO:button_OFF_LEFT = new button_OFF_LEFT(0,0);
    private const bmpCenterO:button_OFF_CENTER = new button_OFF_CENTER(0,0);
    private const bmpRightO:button_OFF_RIGHT = new button_OFF_RIGHT(0,0);
    private const bmpLeftWrong:InputLeftWrong = new InputLeftWrong(0,0);
    private const bmpCenterWrong:InputCenterWrong = new InputCenterWrong(0,0);
    private const bmpRightWrong:InputRightWrong = new InputRightWrong(0,0);

    private var _width:int;
    private var _height:int;

    public var textField:TextField;

    private var oldtime:int = 0;
    private var oldvalue:String = "";
    private var timer:Timer;
    private var _hidden:Boolean;
    private var _locked:Boolean = false;

    public function TankInputL() {
      super();
      addChild(this.bg);
      this.bg.addChild(this.l);
      this.bg.addChild(this.c);
      this.bg.addChild(this.r);
      this._label = new LabelBase();
      this._label.x = -10;
      this._label.y = 7;
      this._label.gridFitType = GridFitType.SUBPIXEL;
      addChild(this._label);
      this.oldtime = getTimer();
      var local1:String = Capabilities.version;
      var local2:RegExp = /^(\w*) (\d*),(\d*),(\d*),(\d*)$/;
      var local3:Object = local2.exec(local1);
      if(local3 != null && Number(local3[2] + "." + local3[3]) < 10.1) {
        this.textField = new TextFieldUtf8Base();
      } else {
        this.textField = new TextField();
      }
      addChild(this.textField);
      this.format.color = 16777215;
      this.textField.defaultTextFormat = this.format;
      this.textField.antiAliasType = AntiAliasType.ADVANCED;
      this.textField.gridFitType = GridFitType.PIXEL;
      this.textField.embedFonts = TanksFontService.isEmbedFonts();
      this.textField.sharpness = FontParamsUtil.SHARPNESS_TANK_INPUT_BASE;
      this.textField.thickness = FontParamsUtil.THICKNESS_TANK_INPUT_BASE;
      this.textField.type = TextFieldType.INPUT;
      this.textField.x = 3;
      this.textField.y = 7;
      this.textField.height = 20;
      this.textField.addEventListener(Event.CHANGE,this.sendTextChangedEvent);
      this.width = 212;
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.textField.width = this._width - 6;
      this.draw();
    }

    override public function set height(param1:Number) : void {
      this._height = int(param1);
      this.draw();
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
      this._label.autoSize = TextFieldAutoSize.RIGHT;
    }

    public function set align(param1:String) : void {
      this.format.align = param1;
      this.updateformat();
    }

    private function updateformat() : void {
      this.textField.defaultTextFormat = this.format;
      this.textField.setTextFormat(this.format);
    }

    public function clear() : void {
      this.textField.text = "";
      this.validValue = true;
    }

    override public function set tabIndex(param1:int) : void {
      this.textField.tabIndex = param1;
    }

    public function set timeout(param1:int) : void {
      this._timeout = param1;
      this.textField.addEventListener(KeyboardEvent.KEY_UP,this.listener);
      this.timer = new Timer(this._timeout);
      this.timer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
      this.textField.removeEventListener(TextEvent.TEXT_INPUT,this.sendTextChangedEvent);
      this.timer.start();
    }

    public function set restrict(param1:String) : void {
      this.textField.restrict = param1;
    }

    public function set maxChars(param1:int) : void {
      this.textField.maxChars = param1;
    }

    public function get value() : String {
      return this._value;
    }

    public function set value(param1:String) : void {
      this.textField.text = this._value = param1;
    }

    public function set hidden(param1:Boolean) : void {
      this._hidden = param1;
      this.textField.displayAsPassword = this._hidden;
      this.textField.defaultTextFormat = this.format;
      this.textField.setTextFormat(this.format);
    }

    public function set validValue(param1:Boolean) : void {
      this._valide = param1;
      this.draw();
    }

    public function get validValue() : Boolean {
      return this._valide;
    }

    private function listener(param1:KeyboardEvent) : void {
      var local2:int = getTimer();
      this.oldtime = local2;
    }

    private function sendTextChangedEvent(param1:Event) : void {
      this._value = this.textField.text;
      dispatchEvent(new LoginFormEvent(LoginFormEvent.TEXT_CHANGED));
    }

    private function onTimeOut(param1:TimerEvent) : void {
      var local2:int = getTimer();
      if(local2 - this.oldtime > this._timeout && this.oldvalue != this.value) {
        this.oldvalue = this.value;
        dispatchEvent(new LoginFormEvent(LoginFormEvent.TEXT_CHANGED));
      }
      this.oldtime = local2;
    }

    public function hide(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.hide);
      this.textField.removeEventListener(TextEvent.TEXT_INPUT,this.sendTextChangedEvent);
      this.textField.removeEventListener(KeyboardEvent.KEY_UP,this.listener);
    }

    public function get locked() : Boolean {
      return this._locked;
    }

    public function set locked(param1:Boolean) : void {
      this._locked = param1;
      this.textField.tabEnabled = !this._locked;
      this.textField.mouseEnabled = !this._locked;
      this.textField.selectable = !this._locked;
      this.textField.type = this._locked ? TextFieldType.DYNAMIC : TextFieldType.INPUT;
      if(this._locked) {
        this.validValue = true;
      }
      this.draw();
    }

    private function draw() : void {
      var local1:Graphics = null;
      local1 = this.l.graphics;
      local1.clear();
      local1.beginBitmapFill(this._valide ? (this._locked ? this.bmpLeftO : this.bmpLeft) : this.bmpLeftWrong);
      local1.drawRect(0,0,5,30);
      local1.endFill();
      this.l.x = 0;
      this.l.y = 0;
      local1 = this.c.graphics;
      local1.clear();
      local1.beginBitmapFill(this._valide ? (this._locked ? this.bmpCenterO : this.bmpCenter) : this.bmpCenterWrong);
      local1.drawRect(0,0,this._width - 10,30);
      local1.endFill();
      this.c.x = 5;
      this.c.y = 0;
      local1 = this.r.graphics;
      local1.clear();
      local1.beginBitmapFill(this._valide ? (this._locked ? this.bmpRightO : this.bmpRight) : this.bmpRightWrong);
      local1.drawRect(0,0,5,30);
      local1.endFill();
      this.r.x = this._width - 5;
      this.r.y = 0;
    }
  }
}
