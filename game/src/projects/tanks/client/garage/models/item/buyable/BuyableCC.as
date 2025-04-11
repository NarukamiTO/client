package projects.tanks.client.garage.models.item.buyable {
  public class BuyableCC {
    private var _buyable:Boolean;
    private var _priceWithoutDiscount:int;

    public function BuyableCC(param1:Boolean = false, param2:int = 0) {
      super();
      this._buyable = param1;
      this._priceWithoutDiscount = param2;
    }

    public function get buyable() : Boolean {
      return this._buyable;
    }

    public function set buyable(param1:Boolean) : void {
      this._buyable = param1;
    }

    public function get priceWithoutDiscount() : int {
      return this._priceWithoutDiscount;
    }

    public function set priceWithoutDiscount(param1:int) : void {
      this._priceWithoutDiscount = param1;
    }

    public function toString() : String {
      var local1:String = "BuyableCC [";
      local1 += "buyable = " + this.buyable + " ";
      local1 += "priceWithoutDiscount = " + this.priceWithoutDiscount + " ";
      return local1 + "]";
    }
  }
}
