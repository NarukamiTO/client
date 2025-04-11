package alternativa.tanks.model.item.shopabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopAbonementAdapt implements ShopAbonement {
    private var object:IGameObject;
    private var impl:ShopAbonement;

    public function ShopAbonementAdapt(param1:IGameObject, param2:ShopAbonement) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getShopCategory() : ShopCategoryEnum {
      var result:ShopCategoryEnum = null;
      try {
        Model.object = this.object;
        result = this.impl.getShopCategory();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
