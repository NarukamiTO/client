package projects.tanks.client.panel.model.payment.modes.gate2shop {
  public class Gate2ShopPaymentCC {
    private var _emailInputRequired:Boolean;

    public function Gate2ShopPaymentCC(param1:Boolean = false) {
      super();
      this._emailInputRequired = param1;
    }

    public function get emailInputRequired() : Boolean {
      return this._emailInputRequired;
    }

    public function set emailInputRequired(param1:Boolean) : void {
      this._emailInputRequired = param1;
    }

    public function toString() : String {
      var local1:String = "Gate2ShopPaymentCC [";
      local1 += "emailInputRequired = " + this.emailInputRequired + " ";
      return local1 + "]";
    }
  }
}
