package projects.tanks.client.panel.model.shop.shopitemcategory {
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemCategoryCC {
    private var _category:IGameObject;

    public function ShopItemCategoryCC(param1:IGameObject = null) {
      super();
      this._category = param1;
    }

    public function get category() : IGameObject {
      return this._category;
    }

    public function set category(param1:IGameObject) : void {
      this._category = param1;
    }

    public function toString() : String {
      var local1:String = "ShopItemCategoryCC [";
      local1 += "category = " + this.category + " ";
      return local1 + "]";
    }
  }
}
