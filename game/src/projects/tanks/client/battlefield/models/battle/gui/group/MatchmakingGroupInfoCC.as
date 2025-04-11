package projects.tanks.client.battlefield.models.battle.gui.group {
  import alternativa.types.Long;

  public class MatchmakingGroupInfoCC {
    private var _groupUserIds:Vector.<Long>;
    private var _hasGroups:Boolean;

    public function MatchmakingGroupInfoCC(param1:Vector.<Long> = null, param2:Boolean = false) {
      super();
      this._groupUserIds = param1;
      this._hasGroups = param2;
    }

    public function get groupUserIds() : Vector.<Long> {
      return this._groupUserIds;
    }

    public function set groupUserIds(param1:Vector.<Long>) : void {
      this._groupUserIds = param1;
    }

    public function get hasGroups() : Boolean {
      return this._hasGroups;
    }

    public function set hasGroups(param1:Boolean) : void {
      this._hasGroups = param1;
    }

    public function toString() : String {
      var local1:String = "MatchmakingGroupInfoCC [";
      local1 += "groupUserIds = " + this.groupUserIds + " ";
      local1 += "hasGroups = " + this.hasGroups + " ";
      return local1 + "]";
    }
  }
}
