package projects.tanks.client.panel.model.shop.featuring {
  public class ShopItemFeaturingCC {
    private var _hiddenInOriginalCategory:Boolean;
    private var _locatedInFeaturingCategory:Boolean;
    private var _position:int;

    public function ShopItemFeaturingCC(param1:Boolean = false, param2:Boolean = false, param3:int = 0) {
      super();
      this._hiddenInOriginalCategory = param1;
      this._locatedInFeaturingCategory = param2;
      this._position = param3;
    }

    public function get hiddenInOriginalCategory() : Boolean {
      return this._hiddenInOriginalCategory;
    }

    public function set hiddenInOriginalCategory(param1:Boolean) : void {
      this._hiddenInOriginalCategory = param1;
    }

    public function get locatedInFeaturingCategory() : Boolean {
      return this._locatedInFeaturingCategory;
    }

    public function set locatedInFeaturingCategory(param1:Boolean) : void {
      this._locatedInFeaturingCategory = param1;
    }

    public function get position() : int {
      return this._position;
    }

    public function set position(param1:int) : void {
      this._position = param1;
    }

    public function toString() : String {
      var local1:String = "ShopItemFeaturingCC [";
      local1 += "hiddenInOriginalCategory = " + this.hiddenInOriginalCategory + " ";
      local1 += "locatedInFeaturingCategory = " + this.locatedInFeaturingCategory + " ";
      local1 += "position = " + this.position + " ";
      return local1 + "]";
    }
  }
}
