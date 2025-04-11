package projects.tanks.client.panel.model.bonus.showing.items {
  import platform.client.fp10.core.type.IGameObject;

  public class BonusItemsShowingCC {
    private var _bonuses:Vector.<IGameObject>;

    public function BonusItemsShowingCC(param1:Vector.<IGameObject> = null) {
      super();
      this._bonuses = param1;
    }

    public function get bonuses() : Vector.<IGameObject> {
      return this._bonuses;
    }

    public function set bonuses(param1:Vector.<IGameObject>) : void {
      this._bonuses = param1;
    }

    public function toString() : String {
      var local1:String = "BonusItemsShowingCC [";
      local1 += "bonuses = " + this.bonuses + " ";
      return local1 + "]";
    }
  }
}
