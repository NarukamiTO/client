package alternativa.tanks.model.payment.shop.itemcategory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemCategoryEvents implements ShopItemCategory {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemCategoryEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCategory() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:ShopItemCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemCategory(this.impl[i]);
          result = m.getCategory();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
