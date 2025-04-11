package projects.tanks.client.panel.model.shop.description {
  public class ShopItemAdditionalDescriptionCC {
    private var _additionalDescription:String;

    public function ShopItemAdditionalDescriptionCC(param1:String = null) {
      super();
      this._additionalDescription = param1;
    }

    public function get additionalDescription() : String {
      return this._additionalDescription;
    }

    public function set additionalDescription(param1:String) : void {
      this._additionalDescription = param1;
    }

    public function toString() : String {
      var local1:String = "ShopItemAdditionalDescriptionCC [";
      local1 += "additionalDescription = " + this.additionalDescription + " ";
      return local1 + "]";
    }
  }
}
