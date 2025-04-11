package alternativa.tanks.model.bonus.showing.items {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;

  public class BonusItemEvents implements BonusItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BonusItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getItem() : BonusItemCC {
      var result:BonusItemCC = null;
      var i:int = 0;
      var m:BonusItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusItem(this.impl[i]);
          result = m.getItem();
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
