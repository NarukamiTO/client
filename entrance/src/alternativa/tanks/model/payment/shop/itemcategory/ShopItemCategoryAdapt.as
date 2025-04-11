package alternativa.tanks.model.payment.shop.itemcategory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemCategoryAdapt implements ShopItemCategory {
    private var object:IGameObject;
    private var impl:ShopItemCategory;

    public function ShopItemCategoryAdapt(param1:IGameObject, param2:ShopItemCategory) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCategory() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getCategory();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
