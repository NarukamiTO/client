package alternativa.tanks.model.payment.shop.onetimepurchase {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemOneTimePurchaseAdapt implements ShopItemOneTimePurchase {
    private var object:IGameObject;
    private var impl:ShopItemOneTimePurchase;

    public function ShopItemOneTimePurchaseAdapt(param1:IGameObject, param2:ShopItemOneTimePurchase) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isOneTimePurchase() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isOneTimePurchase());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isTriedToBuy() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isTriedToBuy());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
