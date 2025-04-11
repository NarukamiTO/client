package projects.tanks.client.panel.model.shop.onetimepurchase {
  public class ShopItemOneTimePurchaseCC {
    private var _oneTimePurchase:Boolean;
    private var _triedToBuy:Boolean;

    public function ShopItemOneTimePurchaseCC(param1:Boolean = false, param2:Boolean = false) {
      super();
      this._oneTimePurchase = param1;
      this._triedToBuy = param2;
    }

    public function get oneTimePurchase() : Boolean {
      return this._oneTimePurchase;
    }

    public function set oneTimePurchase(param1:Boolean) : void {
      this._oneTimePurchase = param1;
    }

    public function get triedToBuy() : Boolean {
      return this._triedToBuy;
    }

    public function set triedToBuy(param1:Boolean) : void {
      this._triedToBuy = param1;
    }

    public function toString() : String {
      var local1:String = "ShopItemOneTimePurchaseCC [";
      local1 += "oneTimePurchase = " + this.oneTimePurchase + " ";
      local1 += "triedToBuy = " + this.triedToBuy + " ";
      return local1 + "]";
    }
  }
}
