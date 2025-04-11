package alternativa.tanks.gui.payment.controls {
  import assets.button.button_OFF_CENTER;
  import assets.button.button_OFF_LEFT;
  import assets.button.button_OFF_RIGHT;
  import assets.icons.InputCheckIcon;
  import controls.base.ColorButtonBase;

  public class ProceedButton extends ColorButtonBase {
    private static const ButtonCenter:Class = ProceedButton_ButtonCenter;
    private static const ButtonLeft:Class = ProceedButton_ButtonLeft;
    private static const ButtonRight:Class = ProceedButton_ButtonRight;
    private static const ButtonOverCenter:Class = ProceedButton_ButtonOverCenter;
    private static const ButtonOverLeft:Class = ProceedButton_ButtonOverLeft;
    private static const ButtonOverRight:Class = ProceedButton_ButtonOverRight;
    private static const ButtonDownCenter:Class = ProceedButton_ButtonDownCenter;
    private static const ButtonDownLeft:Class = ProceedButton_ButtonDownLeft;
    private static const ButtonDownRight:Class = ProceedButton_ButtonDownRight;

    public static const GREEN:String = "green";

    private var wait:InputCheckIcon;

    public function ProceedButton(param1:Boolean = false) {
      super();
      this.setStyle(GREEN);
      if(param1) {
        this.wait = new InputCheckIcon();
        this.wait.visible = false;
        this.wait.gotoAndStop(1);
        addChild(this.wait);
      }
    }

    override public function setStyle(param1:String = "def") : void {
      if(param1 == GREEN) {
        stateUP.bmpLeft = new ButtonLeft().bitmapData;
        stateUP.bmpCenter = new ButtonCenter().bitmapData;
        stateUP.bmpRight = new ButtonRight().bitmapData;
        stateOVER.bmpLeft = new ButtonOverLeft().bitmapData;
        stateOVER.bmpCenter = new ButtonOverCenter().bitmapData;
        stateOVER.bmpRight = new ButtonOverRight().bitmapData;
        stateDOWN.bmpLeft = new ButtonDownLeft().bitmapData;
        stateDOWN.bmpCenter = new ButtonDownCenter().bitmapData;
        stateDOWN.bmpRight = new ButtonDownRight().bitmapData;
        stateOFF.bmpLeft = new button_OFF_LEFT(1,1);
        stateOFF.bmpCenter = new button_OFF_CENTER(1,1);
        stateOFF.bmpRight = new button_OFF_RIGHT(1,1);
      } else {
        super.setStyle(param1);
      }
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.align();
    }

    override public function set x(param1:Number) : void {
      super.x = param1;
      this.align();
    }

    override public function set y(param1:Number) : void {
      super.y = param1;
      this.align();
    }

    override public function get width() : Number {
      return _width;
    }

    override public function set enable(param1:Boolean) : void {
      super.enable = param1;
      if(this.wait != null) {
        this.wait.visible = !param1;
        this.align();
      }
    }

    private function align() : void {
      if(this.wait != null) {
        this.wait.y = int((height - this.wait.height) * 0.5);
        this.wait.x = this.width - this.wait.width - 7;
      }
    }
  }
}
