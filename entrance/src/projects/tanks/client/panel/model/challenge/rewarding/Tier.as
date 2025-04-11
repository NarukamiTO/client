package projects.tanks.client.panel.model.challenge.rewarding {
  public class Tier {
    private var _battlePassItem:TierItem;
    private var _freeItem:TierItem;
    private var _needShowBattlePassItem:Boolean;
    private var _stars:int;

    public function Tier(param1:TierItem = null, param2:TierItem = null, param3:Boolean = false, param4:int = 0) {
      super();
      this._battlePassItem = param1;
      this._freeItem = param2;
      this._needShowBattlePassItem = param3;
      this._stars = param4;
    }

    public function get battlePassItem() : TierItem {
      return this._battlePassItem;
    }

    public function set battlePassItem(param1:TierItem) : void {
      this._battlePassItem = param1;
    }

    public function get freeItem() : TierItem {
      return this._freeItem;
    }

    public function set freeItem(param1:TierItem) : void {
      this._freeItem = param1;
    }

    public function get needShowBattlePassItem() : Boolean {
      return this._needShowBattlePassItem;
    }

    public function set needShowBattlePassItem(param1:Boolean) : void {
      this._needShowBattlePassItem = param1;
    }

    public function get stars() : int {
      return this._stars;
    }

    public function set stars(param1:int) : void {
      this._stars = param1;
    }

    public function toString() : String {
      var local1:String = "Tier [";
      local1 += "battlePassItem = " + this.battlePassItem + " ";
      local1 += "freeItem = " + this.freeItem + " ";
      local1 += "needShowBattlePassItem = " + this.needShowBattlePassItem + " ";
      local1 += "stars = " + this.stars + " ";
      return local1 + "]";
    }
  }
}
