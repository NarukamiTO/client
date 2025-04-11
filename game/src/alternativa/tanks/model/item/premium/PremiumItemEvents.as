package alternativa.tanks.model.item.premium {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PremiumItemEvents implements PremiumItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PremiumItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isPremiumItem() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PremiumItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PremiumItem(this.impl[i]);
          result = Boolean(m.isPremiumItem());
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
