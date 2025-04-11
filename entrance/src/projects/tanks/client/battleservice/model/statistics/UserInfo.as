package projects.tanks.client.battleservice.model.statistics {
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class UserInfo extends UserStat {
    private var _chatModeratorLevel:ChatModeratorLevel;
    private var _hasPremium:Boolean;
    private var _rank:int;
    private var _uid:String;

    public function UserInfo(param1:ChatModeratorLevel = null, param2:Boolean = false, param3:int = 0, param4:String = null) {
      super();
      this._chatModeratorLevel = param1;
      this._hasPremium = param2;
      this._rank = param3;
      this._uid = param4;
    }

    public function get chatModeratorLevel() : ChatModeratorLevel {
      return this._chatModeratorLevel;
    }

    public function set chatModeratorLevel(param1:ChatModeratorLevel) : void {
      this._chatModeratorLevel = param1;
    }

    public function get hasPremium() : Boolean {
      return this._hasPremium;
    }

    public function set hasPremium(param1:Boolean) : void {
      this._hasPremium = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    override public function toString() : String {
      var local1:String = "UserInfo [";
      local1 += "chatModeratorLevel = " + this.chatModeratorLevel + " ";
      local1 += "hasPremium = " + this.hasPremium + " ";
      local1 += "rank = " + this.rank + " ";
      local1 += "uid = " + this.uid + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
