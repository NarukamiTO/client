package projects.tanks.client.panel.model.shop.coinpackage {
  public class CoinPackageCC {
    private var _amount:int;
    private var _bonusAmount:int;

    public function CoinPackageCC(param1:int = 0, param2:int = 0) {
      super();
      this._amount = param1;
      this._bonusAmount = param2;
    }

    public function get amount() : int {
      return this._amount;
    }

    public function set amount(param1:int) : void {
      this._amount = param1;
    }

    public function get bonusAmount() : int {
      return this._bonusAmount;
    }

    public function set bonusAmount(param1:int) : void {
      this._bonusAmount = param1;
    }

    public function toString() : String {
      var local1:String = "CoinPackageCC [";
      local1 += "amount = " + this.amount + " ";
      local1 += "bonusAmount = " + this.bonusAmount + " ";
      return local1 + "]";
    }
  }
}
