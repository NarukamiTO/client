package alternativa.tanks.service.referrals.notification {
  import flash.events.EventDispatcher;

  public class NewReferralsNotifierServiceImpl extends EventDispatcher implements NewReferralsNotifierService {
    private var newReferralsLength:int;

    public function NewReferralsNotifierServiceImpl() {
      super();
    }

    public function newReferralsCountUpdated(param1:int) : void {
      this.newReferralsLength = param1;
      dispatchEvent(new NewReferralsNotifierServiceEvent(NewReferralsNotifierServiceEvent.NEW_REFERRALS_COUNT_UPDATED));
    }

    public function getNewReferralsCount() : int {
      return this.newReferralsLength;
    }

    public function notifyReferralAdded(param1:int) : void {
      this.newReferralsLength = param1;
      dispatchEvent(new NewReferralsNotifierServiceEvent(NewReferralsNotifierServiceEvent.REFERRAL_ADDED));
    }

    public function requestNewReferralsCount() : void {
      dispatchEvent(new NewReferralsNotifierServiceEvent(NewReferralsNotifierServiceEvent.REQUEST_NEW_REFERRALS_COUNT));
    }

    public function resetNewReferralsCount() : void {
      dispatchEvent(new NewReferralsNotifierServiceEvent(NewReferralsNotifierServiceEvent.RESET_NEW_REFERRALS_COUNT));
    }
  }
}
