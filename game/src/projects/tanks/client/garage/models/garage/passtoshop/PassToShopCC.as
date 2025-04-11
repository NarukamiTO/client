package projects.tanks.client.garage.models.garage.passtoshop {
  public class PassToShopCC {
    private var _passToShopEnabled:Boolean;

    public function PassToShopCC(param1:Boolean = false) {
      super();
      this._passToShopEnabled = param1;
    }

    public function get passToShopEnabled() : Boolean {
      return this._passToShopEnabled;
    }

    public function set passToShopEnabled(param1:Boolean) : void {
      this._passToShopEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "PassToShopCC [";
      local1 += "passToShopEnabled = " + this.passToShopEnabled + " ";
      return local1 + "]";
    }
  }
}
