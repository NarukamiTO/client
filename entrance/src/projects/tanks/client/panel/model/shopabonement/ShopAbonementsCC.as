package projects.tanks.client.panel.model.shopabonement {
  import platform.client.fp10.core.type.IGameObject;

  public class ShopAbonementsCC {
    private var _categoriesWithBonus:Vector.<IGameObject>;

    public function ShopAbonementsCC(param1:Vector.<IGameObject> = null) {
      super();
      this._categoriesWithBonus = param1;
    }

    public function get categoriesWithBonus() : Vector.<IGameObject> {
      return this._categoriesWithBonus;
    }

    public function set categoriesWithBonus(param1:Vector.<IGameObject>) : void {
      this._categoriesWithBonus = param1;
    }

    public function toString() : String {
      var local1:String = "ShopAbonementsCC [";
      local1 += "categoriesWithBonus = " + this.categoriesWithBonus + " ";
      return local1 + "]";
    }
  }
}
