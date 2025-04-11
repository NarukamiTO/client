package alternativa.tanks.model.item.discount.proabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ProAbonementRankDiscountEvents implements ProAbonementRankDiscount {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ProAbonementRankDiscountEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRankDiscount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ProAbonementRankDiscount = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ProAbonementRankDiscount(this.impl[i]);
          result = int(m.getRankDiscount());
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
