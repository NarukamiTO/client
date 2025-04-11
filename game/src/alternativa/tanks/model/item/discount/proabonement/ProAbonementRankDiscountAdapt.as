package alternativa.tanks.model.item.discount.proabonement {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ProAbonementRankDiscountAdapt implements ProAbonementRankDiscount {
    private var object:IGameObject;
    private var impl:ProAbonementRankDiscount;

    public function ProAbonementRankDiscountAdapt(param1:IGameObject, param2:ProAbonementRankDiscount) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRankDiscount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getRankDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
