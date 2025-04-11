package projects.tanks.client.panel.model.shop.discount {
  public class ShopDiscountCC {
    private var _discountInPercent:int;
    private var _enabled:Boolean;

    public function ShopDiscountCC(param1:int = 0, param2:Boolean = false) {
      super();
      this._discountInPercent = param1;
      this._enabled = param2;
    }

    public function get discountInPercent() : int {
      return this._discountInPercent;
    }

    public function set discountInPercent(param1:int) : void {
      this._discountInPercent = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function toString() : String {
      var local1:String = "ShopDiscountCC [";
      local1 += "discountInPercent = " + this.discountInPercent + " ";
      local1 += "enabled = " + this.enabled + " ";
      return local1 + "]";
    }
  }
}
