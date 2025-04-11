package alternativa.tanks.gui.payment.forms.paymentstatus {
  import assets.icons.InputCheckIcon;
  import base.DiscreteSprite;
  import controls.labels.MouseDisabledLabel;

  public class PaymentStatusLine extends DiscreteSprite {
    private var label:MouseDisabledLabel = new MouseDisabledLabel();
    private var wait:InputCheckIcon = new InputCheckIcon();

    public function PaymentStatusLine(param1:String) {
      super();
      mouseChildren = false;
      mouseEnabled = false;
      this.label.text = param1;
      this.wait.gotoAndStop(1);
      this.wait.x = this.label.width + 13;
      this.wait.y = this.label.height - this.wait.height >> 1;
      addChild(this.label);
      addChild(this.wait);
    }

    public function showProgressWorking() : void {
      this.wait.gotoAndStop(1);
    }

    public function showProgressDone() : void {
      this.wait.gotoAndStop(2);
    }
  }
}
