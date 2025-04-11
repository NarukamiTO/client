package projects.tanks.client.panel.model.payment.modes.paygarden {
  public class PayGardenPaymentCC {
    private var _productType:PayGardenProductType;

    public function PayGardenPaymentCC(param1:PayGardenProductType = null) {
      super();
      this._productType = param1;
    }

    public function get productType() : PayGardenProductType {
      return this._productType;
    }

    public function set productType(param1:PayGardenProductType) : void {
      this._productType = param1;
    }

    public function toString() : String {
      var local1:String = "PayGardenPaymentCC [";
      local1 += "productType = " + this.productType + " ";
      return local1 + "]";
    }
  }
}
