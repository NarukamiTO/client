package projects.tanks.client.panel.model.payment.modes.braintree {
  public class BraintreePaymentCC {
    private var _payPal:Boolean;

    public function BraintreePaymentCC(param1:Boolean = false) {
      super();
      this._payPal = param1;
    }

    public function get payPal() : Boolean {
      return this._payPal;
    }

    public function set payPal(param1:Boolean) : void {
      this._payPal = param1;
    }

    public function toString() : String {
      var local1:String = "BraintreePaymentCC [";
      local1 += "payPal = " + this.payPal + " ";
      return local1 + "]";
    }
  }
}
