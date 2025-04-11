package projects.tanks.client.chat.types {
  import alternativa.types.Long;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class UserStatus {
    private var _chatModeratorLevel:ChatModeratorLevel;
    private var _ip:String;
    private var _rankIndex:int;
    private var _uid:String;
    private var _userId:Long;

    public function UserStatus(param1:ChatModeratorLevel = null, param2:String = null, param3:int = 0, param4:String = null, param5:Long = null) {
      super();
      this._chatModeratorLevel = param1;
      this._ip = param2;
      this._rankIndex = param3;
      this._uid = param4;
      this._userId = param5;
    }

    public function get chatModeratorLevel() : ChatModeratorLevel {
      return this._chatModeratorLevel;
    }

    public function set chatModeratorLevel(param1:ChatModeratorLevel) : void {
      this._chatModeratorLevel = param1;
    }

    public function get ip() : String {
      return this._ip;
    }

    public function set ip(param1:String) : void {
      this._ip = param1;
    }

    public function get rankIndex() : int {
      return this._rankIndex;
    }

    public function set rankIndex(param1:int) : void {
      this._rankIndex = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function toString() : String {
      var local1:String = "UserStatus [";
      local1 += "chatModeratorLevel = " + this.chatModeratorLevel + " ";
      local1 += "ip = " + this.ip + " ";
      local1 += "rankIndex = " + this.rankIndex + " ";
      local1 += "uid = " + this.uid + " ";
      local1 += "userId = " + this.userId + " ";
      return local1 + "]";
    }
  }
}
