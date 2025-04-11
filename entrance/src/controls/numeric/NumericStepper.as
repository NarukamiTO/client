package controls.numeric {
  import controls.StepperButton;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;

  public class NumericStepper extends NumericEditor implements INumericStepper {
    protected var button:StepperButton = new StepperButton();

    private var timerStepper:TimerStepper;
    private var buttonStatus:int = 0;

    public function NumericStepper(param1:Boolean = false) {
      super(param1);
      addChild(this.button);
      this.button.x = 75;
      if(!param1) {
        tf.textField.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,0,true);
      }
      this.timerStepper = new TimerStepper(this,step);
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      this.timerStepper.stop();
      this.buttonStatus = 0;
    }

    override protected function onKeyDown(param1:KeyboardEvent) : void {
      super.onKeyDown(param1);
      if(this.buttonStatus == 0) {
        switch(param1.keyCode) {
          case Keyboard.UP:
            setValue(getValue() + step,true);
            this.timerStepper.start();
            this.buttonStatus = 1;
            break;
          case Keyboard.DOWN:
            setValue(getValue() - step,true);
            this.buttonStatus = -1;
            this.timerStepper.start();
        }
      }
    }

    override public function set enabled(param1:Boolean) : void {
      super.enabled = param1;
      if(param1) {
        this.button.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
        this.button.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
        this.button.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp,false,0,true);
        this.button.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove,false,0,true);
      } else {
        this.button.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
        this.button.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        this.button.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp);
      }
    }

    private function onMouseMove(param1:MouseEvent) : void {
      if(param1.buttonDown) {
        this.button.gotoAndStop(this.button.mouseY < 15 ? 2 : 3);
      }
    }

    protected function onMouseDown(param1:MouseEvent) : void {
      stage.focus = this.button;
      this.onMouseMove(param1);
      setValue(_value + this.getButtonStatus() * step,true);
      this.timerStepper.start();
    }

    protected function onMouseUp(param1:MouseEvent) : void {
      this.button.gotoAndStop(1);
      this.timerStepper.stop();
    }

    public function getButtonStatus() : int {
      if(stage.focus == this.button) {
        return this.button.mouseY < 15 ? 1 : -1;
      }
      if(stage.focus == tf.textField) {
        return this.buttonStatus;
      }
      return 0;
    }

    override public function isFocused() : Boolean {
      return super.isFocused() || stage != null && stage.focus == this.button;
    }

    override public function setStep(param1:Number) : void {
      super.setStep(param1);
      this.timerStepper.setStep(param1);
    }

    override public function setWidth(param1:int) : void {
      super.setWidth(param1);
      this.button.x = param1 + 1;
    }

    override public function get width() : Number {
      return this.button.x + this.button.width;
    }
  }
}
