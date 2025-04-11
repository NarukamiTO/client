package controls.base {
  import controls.ValidationIcon;
  import flash.events.FocusEvent;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;

  public class TankInputBox extends TankInputBase {
    private const CHECK_CALLSIGN_DELAY:int = 500;

    private var checkTimer:Timer;
    private var validateCheckIcon:ValidationIcon;
    private var labelBase:LabelBase = new LabelBase();
    private var _validateFunction:Function;
    private var validatorVisible:Boolean;
    private var _isValid:Boolean = false;
    private var _isEnabled:Boolean = false;
    private var _isValidating:Boolean = false;

    public function TankInputBox(param1:String, param2:Boolean = false) {
      super();
      this.validatorVisible = param2;
      this.labelBase.text = param1;
      this.labelBase.mouseEnabled = false;
      this.labelBase.color = ColorConstants.LIST_LABEL_HINT;
      addChild(this.labelBase);
      if(this.validatorVisible) {
        this.validateCheckIcon = new ValidationIcon();
        addChild(this.validateCheckIcon);
        this.checkTimer = new Timer(this.CHECK_CALLSIGN_DELAY,1);
        this.checkTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCheckTimerComplete);
      }
      addEventListener(FocusEvent.FOCUS_IN,this.onFocusInInput);
      addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutInput);
      addEventListener(LoginFormEvent.TEXT_CHANGED,this.onInputChanged);
      this.resize();
    }

    public function isValid() : Boolean {
      return this._isValid;
    }

    private function resize() : void {
      this.labelBase.x = 3;
      this.labelBase.y = 7;
      if(this.validatorVisible) {
        this.validateCheckIcon.x = width - 33;
        this.validateCheckIcon.y = 7;
      }
    }

    private function onFocusInInput(param1:FocusEvent) : void {
      this.labelBase.visible = false;
    }

    private function onFocusOutInput(param1:FocusEvent) : void {
      if(value.length == 0) {
        this.labelBase.visible = true;
      }
    }

    private function onInputChanged(param1:LoginFormEvent) : void {
      if(!this.validatorVisible) {
        return;
      }
      if(value.length == 0) {
        this.validateCheckIcon.turnOff();
      }
      this.checkTimer.reset();
      this.checkTimer.start();
      this._isValidating = true;
    }

    public function valid() : void {
      this._isValidating = false;
      if(this.validatorVisible) {
        this._isValid = true;
        validValue = true;
        this.validateCheckIcon.markAsValid();
      }
    }

    public function get isValidating() : Boolean {
      return this._isValidating;
    }

    public function invalid() : void {
      this._isValidating = false;
      if(this.validatorVisible) {
        this._isValid = false;
        validValue = false;
        this.validateCheckIcon.markAsInvalid();
      }
    }

    private function onCheckTimerComplete(param1:TimerEvent) : void {
      if(value.length > 0) {
        this.validateCheckIcon.startProgress();
        if(this.validateFunction != null) {
          this.validateFunction.call(this);
        }
      }
    }

    public function set validateFunction(param1:Function) : void {
      this._validateFunction = param1;
    }

    public function get validateFunction() : Function {
      return this._validateFunction;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.resize();
    }

    override public function set enable(param1:Boolean) : void {
      super.enable = param1;
      this._isEnabled = param1;
    }

    public function isEnabled() : Boolean {
      return this._isEnabled;
    }
  }
}
