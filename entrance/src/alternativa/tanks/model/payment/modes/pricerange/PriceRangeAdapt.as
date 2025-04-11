package alternativa.tanks.model.payment.modes.pricerange {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PriceRangeAdapt implements PriceRange {
    private var object:IGameObject;
    private var impl:PriceRange;

    public function PriceRangeAdapt(param1:IGameObject, param2:PriceRange) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function priceIsValid(param1:Number) : Boolean {
      var result:Boolean = false;
      var price:Number = param1;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.priceIsValid(price));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
