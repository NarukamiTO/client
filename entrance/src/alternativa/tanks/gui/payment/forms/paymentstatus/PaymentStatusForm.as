package alternativa.tanks.gui.payment.forms.paymentstatus {
  import base.DiscreteSprite;

  public class PaymentStatusForm extends DiscreteSprite {
    private static const WIDTH:int = 270;

    private var line:PaymentStatusLine;

    public function PaymentStatusForm(param1:String) {
      super();
      this.line = new PaymentStatusLine(param1);
      this.line.x = WIDTH - this.line.width >> 1;
      addChild(this.line);
    }

    public function showProgressWorking() : void {
      this.line.showProgressWorking();
    }

    public function showProgressDone() : void {
      this.line.showProgressDone();
    }
  }
}
