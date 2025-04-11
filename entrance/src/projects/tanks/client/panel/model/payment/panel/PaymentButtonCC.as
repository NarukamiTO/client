package projects.tanks.client.panel.model.payment.panel {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PaymentButtonCC {
    private var _enabledFullPayment:Boolean;
    private var _paymentUrl:PaymentRequestUrl;

    public function PaymentButtonCC(param1:Boolean = false, param2:PaymentRequestUrl = null) {
      super();
      this._enabledFullPayment = param1;
      this._paymentUrl = param2;
    }

    public function get enabledFullPayment() : Boolean {
      return this._enabledFullPayment;
    }

    public function set enabledFullPayment(param1:Boolean) : void {
      this._enabledFullPayment = param1;
    }

    public function get paymentUrl() : PaymentRequestUrl {
      return this._paymentUrl;
    }

    public function set paymentUrl(param1:PaymentRequestUrl) : void {
      this._paymentUrl = param1;
    }

    public function toString() : String {
      var local1:String = "PaymentButtonCC [";
      local1 += "enabledFullPayment = " + this.enabledFullPayment + " ";
      local1 += "paymentUrl = " + this.paymentUrl + " ";
      return local1 + "]";
    }
  }
}
