package projects.tanks.client.battleselect.model.battle.dm {
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleDMInfoCC {
    private var _users:Vector.<BattleInfoUser>;

    public function BattleDMInfoCC(param1:Vector.<BattleInfoUser> = null) {
      super();
      this._users = param1;
    }

    public function get users() : Vector.<BattleInfoUser> {
      return this._users;
    }

    public function set users(param1:Vector.<BattleInfoUser>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "BattleDMInfoCC [";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
