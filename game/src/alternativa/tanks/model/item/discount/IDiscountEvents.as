package alternativa.tanks.model.item.discount {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDiscountEvents implements IDiscount {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IDiscountEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDiscountInPercent() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IDiscount = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDiscount(this.impl[i]);
          result = int(m.getDiscountInPercent());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function applyDiscount(param1:int) : int {
      var result:int = 0;
      var i:int = 0;
      var m:IDiscount = null;
      var price:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDiscount(this.impl[i]);
          result = int(m.applyDiscount(price));
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
