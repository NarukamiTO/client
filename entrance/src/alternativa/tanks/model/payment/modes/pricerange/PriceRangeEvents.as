package alternativa.tanks.model.payment.modes.pricerange {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PriceRangeEvents implements PriceRange {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PriceRangeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function priceIsValid(param1:Number) : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PriceRange = null;
      var price:Number = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PriceRange(this.impl[i]);
          result = Boolean(m.priceIsValid(price));
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
