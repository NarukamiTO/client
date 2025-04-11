package alternativa.tanks.models.tank {
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class UserInfo {
    public var name:String;
    public var rank:int;
    public var isLocal:Boolean;
    public var chatModeratorLevel:ChatModeratorLevel;
    public var hasPremium:Boolean;

    public function UserInfo(param1:String, param2:int, param3:Boolean, param4:ChatModeratorLevel, param5:Boolean) {
      super();
      this.name = param1;
      this.rank = param2;
      this.isLocal = param3;
      this.chatModeratorLevel = param4;
      this.hasPremium = param5;
    }
  }
}
