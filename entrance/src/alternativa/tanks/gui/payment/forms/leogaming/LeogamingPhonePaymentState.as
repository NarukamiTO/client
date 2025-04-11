package alternativa.tanks.gui.payment.forms.leogaming {
  public class LeogamingPhonePaymentState {
    public static const PHONE:* = new LeogamingPhonePaymentState(0);
    public static const CONFIRM:* = new LeogamingPhonePaymentState(1);
    public static const WAIT:* = new LeogamingPhonePaymentState(2);

    private var state:int = 0;

    public function LeogamingPhonePaymentState(param1:int) {
      super();
      this.state = param1;
    }
  }
}
