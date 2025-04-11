package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle {
  import alternativa.types.Long;
  import flash.events.Event;

  public class LeaveBattleNotifierServiceEvent extends Event {
    public static const LEAVE:String = "LeaveBattleNotifierServiceEvent.LEAVE_BATTLE";

    public var userId:Long;

    public function LeaveBattleNotifierServiceEvent(param1:String, param2:Long, param3:Boolean = false, param4:Boolean = false) {
      this.userId = param2;
      super(param1,param3,param4);
    }
  }
}
