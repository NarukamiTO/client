package projects.tanks.client.battleselect.model.matchmaking.group.notify {
  public class MatchmakingGroupCC {
    private var _users:Vector.<MatchmakingUserData>;

    public function MatchmakingGroupCC(param1:Vector.<MatchmakingUserData> = null) {
      super();
      this._users = param1;
    }

    public function get users() : Vector.<MatchmakingUserData> {
      return this._users;
    }

    public function set users(param1:Vector.<MatchmakingUserData>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "MatchmakingGroupCC [";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
