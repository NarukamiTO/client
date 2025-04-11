package projects.tanks.client.panel.model.battlepass.purchasenotifier {
  public class BattlePassPurchaseNotifierCC {
    private var _purchased:Boolean;

    public function BattlePassPurchaseNotifierCC(param1:Boolean = false) {
      super();
      this._purchased = param1;
    }

    public function get purchased() : Boolean {
      return this._purchased;
    }

    public function set purchased(param1:Boolean) : void {
      this._purchased = param1;
    }

    public function toString() : String {
      var local1:String = "BattlePassPurchaseNotifierCC [";
      local1 += "purchased = " + this.purchased + " ";
      return local1 + "]";
    }
  }
}
