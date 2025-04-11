package alternativa.tanks.service.referrals.notification {
  import flash.events.IEventDispatcher;

  public interface NewReferralsNotifierService extends IEventDispatcher {
    function newReferralsCountUpdated(param1:int) : void;
    function notifyReferralAdded(param1:int) : void;
    function requestNewReferralsCount() : void;
    function resetNewReferralsCount() : void;
    function getNewReferralsCount() : int;
  }
}
