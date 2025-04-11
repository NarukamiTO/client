package alternativa.tanks.model.payment.shop.discount {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopDiscountEvents implements ShopDiscount {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopDiscountEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopDiscount = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopDiscount(this.impl[i]);
          result = Boolean(m.isEnabled());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function applyDiscount(param1:Number) : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:ShopDiscount = null;
      var price:Number = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopDiscount(this.impl[i]);
          result = Number(m.applyDiscount(price));
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
