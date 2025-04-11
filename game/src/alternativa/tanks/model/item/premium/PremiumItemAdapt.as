package alternativa.tanks.model.item.premium {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PremiumItemAdapt implements PremiumItem {
    private var object:IGameObject;
    private var impl:PremiumItem;

    public function PremiumItemAdapt(param1:IGameObject, param2:PremiumItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isPremiumItem() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isPremiumItem());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
