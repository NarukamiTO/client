package alternativa.tanks.model.payment.shop.shopabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopAbonementsEvents implements ShopAbonements {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopAbonementsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCategoriesWithBonus() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      var i:int = 0;
      var m:ShopAbonements = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopAbonements(this.impl[i]);
          result = m.getCategoriesWithBonus();
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
