package alternativa.tanks.model.bonus.showing.items {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;

  public class BonusItemAdapt implements BonusItem {
    private var object:IGameObject;
    private var impl:BonusItem;

    public function BonusItemAdapt(param1:IGameObject, param2:BonusItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getItem() : BonusItemCC {
      var result:BonusItemCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getItem();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
