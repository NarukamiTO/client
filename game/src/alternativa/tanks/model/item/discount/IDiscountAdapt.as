package alternativa.tanks.model.item.discount {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDiscountAdapt implements IDiscount {
    private var object:IGameObject;
    private var impl:IDiscount;

    public function IDiscountAdapt(param1:IGameObject, param2:IDiscount) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDiscountInPercent() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getDiscountInPercent());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function applyDiscount(param1:int) : int {
      var result:int = 0;
      var price:int = param1;
      try {
        Model.object = this.object;
        result = int(this.impl.applyDiscount(price));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
