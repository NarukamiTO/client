package projects.tanks.client.panel.model.payment.modes.android {
  public class PurchaseData {
    private var _currency:String;
    private var _itemId:String;
    private var _token:String;

    public function PurchaseData(param1:String = null, param2:String = null, param3:String = null) {
      super();
      this._currency = param1;
      this._itemId = param2;
      this._token = param3;
    }

    public function get currency() : String {
      return this._currency;
    }

    public function set currency(param1:String) : void {
      this._currency = param1;
    }

    public function get itemId() : String {
      return this._itemId;
    }

    public function set itemId(param1:String) : void {
      this._itemId = param1;
    }

    public function get token() : String {
      return this._token;
    }

    public function set token(param1:String) : void {
      this._token = param1;
    }

    public function toString() : String {
      var local1:String = "PurchaseData [";
      local1 += "currency = " + this.currency + " ";
      local1 += "itemId = " + this.itemId + " ";
      local1 += "token = " + this.token + " ";
      return local1 + "]";
    }
  }
}
