package projects.tanks.client.clans.clan.clanmembersdata {
  public class ClanMembersCC {
    private var _users:Vector.<UserData>;

    public function ClanMembersCC(param1:Vector.<UserData> = null) {
      super();
      this._users = param1;
    }

    public function get users() : Vector.<UserData> {
      return this._users;
    }

    public function set users(param1:Vector.<UserData>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "ClanMembersCC [";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
