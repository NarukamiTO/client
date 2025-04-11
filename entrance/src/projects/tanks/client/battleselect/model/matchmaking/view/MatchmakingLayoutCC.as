package projects.tanks.client.battleselect.model.matchmaking.view {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.matchmaking.modes.MatchmakingModeRank;

  public class MatchmakingLayoutCC {
    private var _holidayDescription:String;
    private var _holidayEnabled:Boolean;
    private var _holidayIcon:ImageResource;
    private var _holidayTitle:String;
    private var _matchmakingModeRanks:Vector.<MatchmakingModeRank>;
    private var _minRankForProBattle:int;

    public function MatchmakingLayoutCC(param1:String = null, param2:Boolean = false, param3:ImageResource = null, param4:String = null, param5:Vector.<MatchmakingModeRank> = null, param6:int = 0) {
      super();
      this._holidayDescription = param1;
      this._holidayEnabled = param2;
      this._holidayIcon = param3;
      this._holidayTitle = param4;
      this._matchmakingModeRanks = param5;
      this._minRankForProBattle = param6;
    }

    public function get holidayDescription() : String {
      return this._holidayDescription;
    }

    public function set holidayDescription(param1:String) : void {
      this._holidayDescription = param1;
    }

    public function get holidayEnabled() : Boolean {
      return this._holidayEnabled;
    }

    public function set holidayEnabled(param1:Boolean) : void {
      this._holidayEnabled = param1;
    }

    public function get holidayIcon() : ImageResource {
      return this._holidayIcon;
    }

    public function set holidayIcon(param1:ImageResource) : void {
      this._holidayIcon = param1;
    }

    public function get holidayTitle() : String {
      return this._holidayTitle;
    }

    public function set holidayTitle(param1:String) : void {
      this._holidayTitle = param1;
    }

    public function get matchmakingModeRanks() : Vector.<MatchmakingModeRank> {
      return this._matchmakingModeRanks;
    }

    public function set matchmakingModeRanks(param1:Vector.<MatchmakingModeRank>) : void {
      this._matchmakingModeRanks = param1;
    }

    public function get minRankForProBattle() : int {
      return this._minRankForProBattle;
    }

    public function set minRankForProBattle(param1:int) : void {
      this._minRankForProBattle = param1;
    }

    public function toString() : String {
      var local1:String = "MatchmakingLayoutCC [";
      local1 += "holidayDescription = " + this.holidayDescription + " ";
      local1 += "holidayEnabled = " + this.holidayEnabled + " ";
      local1 += "holidayIcon = " + this.holidayIcon + " ";
      local1 += "holidayTitle = " + this.holidayTitle + " ";
      local1 += "matchmakingModeRanks = " + this.matchmakingModeRanks + " ";
      local1 += "minRankForProBattle = " + this.minRankForProBattle + " ";
      return local1 + "]";
    }
  }
}
