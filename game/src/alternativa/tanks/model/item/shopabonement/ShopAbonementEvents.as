package alternativa.tanks.model.item.shopabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopAbonementEvents implements ShopAbonement {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopAbonementEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getShopCategory() : ShopCategoryEnum {
      var result:ShopCategoryEnum = null;
      var i:int = 0;
      var m:ShopAbonement = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopAbonement(this.impl[i]);
          result = m.getShopCategory();
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
