package alternativa.tanks.model.payment.shop.onetimepurchase {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemOneTimePurchaseEvents implements ShopItemOneTimePurchase {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopItemOneTimePurchaseEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isOneTimePurchase() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemOneTimePurchase = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemOneTimePurchase(this.impl[i]);
          result = Boolean(m.isOneTimePurchase());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isTriedToBuy() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopItemOneTimePurchase = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopItemOneTimePurchase(this.impl[i]);
          result = Boolean(m.isTriedToBuy());
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
