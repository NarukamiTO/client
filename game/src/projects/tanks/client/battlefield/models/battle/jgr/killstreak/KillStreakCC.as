package projects.tanks.client.battlefield.models.battle.jgr.killstreak {
  public class KillStreakCC {
    private var _items:Vector.<KillStreakItem>;

    public function KillStreakCC(param1:Vector.<KillStreakItem> = null) {
      super();
      this._items = param1;
    }

    public function get items() : Vector.<KillStreakItem> {
      return this._items;
    }

    public function set items(param1:Vector.<KillStreakItem>) : void {
      this._items = param1;
    }

    public function toString() : String {
      var local1:String = "KillStreakCC [";
      local1 += "items = " + this.items + " ";
      return local1 + "]";
    }
  }
}
