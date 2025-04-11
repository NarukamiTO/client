package projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite {
  import alternativa.types.Long;
  import flash.events.Event;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class BattleInviteServiceEvent extends Event {
    public static const INVITE:String = "BattleInviteServiceEvent.INVITE";
    public static const ACCEPT:String = "BattleInviteServiceEvent.ACCEPT";
    public static const REJECT:String = "BattleInviteServiceEvent.REJECT";
    public static const REMOVE_INVITE:String = "BattleInviteServiceEvent.REMOVE_INVITE";

    public var userId:Long;
    public var battleData:BattleInfoData;

    public function BattleInviteServiceEvent(param1:String, param2:Long) {
      super(param1);
      this.userId = param2;
    }
  }
}
