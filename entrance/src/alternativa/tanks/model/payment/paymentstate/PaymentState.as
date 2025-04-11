package alternativa.tanks.model.payment.paymentstate {
  public final class PaymentState {
    public static const ITEM_CHOOSE:PaymentState = new PaymentState("ITEM_CHOOSE");
    public static const PAYMODE_CHOOSE:PaymentState = new PaymentState("PAYMODE_CHOOSE");
    public static const PAY_FORM:PaymentState = new PaymentState("PAY_FORM");
    public static const PAY_FORM_WITHOUT_CHOSEN_ITEM:PaymentState = new PaymentState("PAY_FORM_WITHOUT_CHOSEN_ITEM");
    public static const PAY_FORM_ONE_TIME_PURCHASE:PaymentState = new PaymentState("PAY_FORM_ONE_TIME_PURCHASE");
    public static const PAYMENT_FLOW:Array = [ITEM_CHOOSE,PAYMODE_CHOOSE,PAY_FORM];

    private var stateLabel:String;

    public function PaymentState(param1:String) {
      super();
      this.stateLabel = param1;
    }

    public function toString() : String {
      return this.stateLabel;
    }
  }
}
