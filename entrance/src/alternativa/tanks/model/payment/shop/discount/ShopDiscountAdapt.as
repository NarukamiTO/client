package alternativa.tanks.model.payment.shop.discount {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopDiscountAdapt implements ShopDiscount {
    private var object:IGameObject;
    private var impl:ShopDiscount;

    public function ShopDiscountAdapt(param1:IGameObject, param2:ShopDiscount) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function applyDiscount(param1:Number) : Number {
      var result:Number = NaN;
      var price:Number = param1;
      try {
        Model.object = this.object;
        result = Number(this.impl.applyDiscount(price));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
