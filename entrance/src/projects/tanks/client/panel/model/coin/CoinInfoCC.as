package projects.tanks.client.panel.model.coin {
  public class CoinInfoCC {
    private var _coins:int;
    private var _enabled:Boolean;

    public function CoinInfoCC(param1:int = 0, param2:Boolean = false) {
      super();
      this._coins = param1;
      this._enabled = param2;
    }

    public function get coins() : int {
      return this._coins;
    }

    public function set coins(param1:int) : void {
      this._coins = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function toString() : String {
      var local1:String = "CoinInfoCC [";
      local1 += "coins = " + this.coins + " ";
      local1 += "enabled = " + this.enabled + " ";
      return local1 + "]";
    }
  }
}
