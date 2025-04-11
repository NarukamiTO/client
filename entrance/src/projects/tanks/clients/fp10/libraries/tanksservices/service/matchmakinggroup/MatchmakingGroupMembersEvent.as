package projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup {
  import alternativa.types.Long;
  import flash.events.Event;

  public class MatchmakingGroupMembersEvent extends Event {
    public static const INVITE:String = "InviteToMatchmakingGroupEvent.INVITE";
    public static const REMOVE:String = "InviteToMatchmakingGroupEvent.REMOVE";

    private var userId:Long;

    public function MatchmakingGroupMembersEvent(param1:String, param2:Long) {
      this.userId = param2;
      super(param1);
    }

    public function getUserId() : Long {
      return this.userId;
    }
  }
}
