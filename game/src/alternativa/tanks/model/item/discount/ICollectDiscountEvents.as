package alternativa.tanks.model.item.discount {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ICollectDiscountEvents implements ICollectDiscount {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ICollectDiscountEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      var i:int = 0;
      var m:ICollectDiscount = null;
      var collector:IDiscountCollector = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICollectDiscount(this.impl[i]);
          m.collectDiscountsInfo(collector);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
