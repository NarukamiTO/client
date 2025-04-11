package alternativa.tanks.service.referrals.notification {
  import flash.events.Event;

  public class NewReferralsNotifierServiceEvent extends Event {
    public static const NEW_REFERRALS_COUNT_UPDATED:String = "NewReferralsNotifierServiceEvent.NEW_REFERRALS_COUNT_UPDATED";
    public static const REFERRAL_ADDED:String = "NewReferralsNotifierServiceEvent.REFERRAL_ADDED";
    public static const REQUEST_NEW_REFERRALS_COUNT:String = "NewReferralsNotifierServiceEvent.REQUEST_NEW_REFERRALS_COUNT";
    public static const RESET_NEW_REFERRALS_COUNT:String = "NewReferralsNotifierServiceEvent.RESET_NEW_REFERRALS_COUNT";

    public function NewReferralsNotifierServiceEvent(param1:String) {
      super(param1);
    }
  }
}
