package alternativa.tanks.model.payment.shop.shopabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopAbonementsAdapt implements ShopAbonements {
    private var object:IGameObject;
    private var impl:ShopAbonements;

    public function ShopAbonementsAdapt(param1:IGameObject, param2:ShopAbonements) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCategoriesWithBonus() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      try {
        Model.object = this.object;
        result = this.impl.getCategoriesWithBonus();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
