package projects.tanks.client.battleselect.model.matchmaking.modes {
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class MatchmakingModeRank {
    private var _matchmakingMode:MatchmakingMode;
    private var _rank:int;

    public function MatchmakingModeRank(param1:MatchmakingMode = null, param2:int = 0) {
      super();
      this._matchmakingMode = param1;
      this._rank = param2;
    }

    public function get matchmakingMode() : MatchmakingMode {
      return this._matchmakingMode;
    }

    public function set matchmakingMode(param1:MatchmakingMode) : void {
      this._matchmakingMode = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function toString() : String {
      var local1:String = "MatchmakingModeRank [";
      local1 += "matchmakingMode = " + this.matchmakingMode + " ";
      local1 += "rank = " + this.rank + " ";
      return local1 + "]";
    }
  }
}
