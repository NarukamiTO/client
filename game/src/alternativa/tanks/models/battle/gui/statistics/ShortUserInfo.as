package alternativa.tanks.models.battle.gui.statistics {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class ShortUserInfo {
    public var userId:Long;
    public var uid:String;
    public var rank:int;
    public var suspicious:Boolean;
    public var teamType:BattleTeam;
    public var chatModeratorLevel:ChatModeratorLevel;
    public var hasPremium:Boolean;

    public function ShortUserInfo() {
      super();
    }
  }
}
