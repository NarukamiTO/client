package projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite {
  import alternativa.types.Long;
  import flash.events.Event;

  public class GroupInviteServiceEvent extends Event {
    public static const ACCEPT:String = "GroupInviteServiceEvent.ACCEPT";
    public static const REJECT:String = "GroupInviteServiceEvent.REJECT";

    public var sender:Long;

    public function GroupInviteServiceEvent(param1:String, param2:Long) {
      this.sender = param2;
      super(param1);
    }
  }
}
