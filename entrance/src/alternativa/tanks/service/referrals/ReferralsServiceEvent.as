package alternativa.tanks.service.referrals {
  import flash.events.Event;

  public class ReferralsServiceEvent extends Event {
    public static const UPDATE_DATA_REQUEST:String = "ReferralsServiceEvent.UPDATE_DATA_REQUEST";
    public static const DATA_UPDATED:String = "ReferralsServiceEvent.DATA_UPDATED";

    public function ReferralsServiceEvent(param1:String) {
      super(param1,true);
    }
  }
}
