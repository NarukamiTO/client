package alternativa.tanks.service.referrals {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;

  public interface ReferralsService extends IEventDispatcher {
    function updateReferralsData(param1:Vector.<ReferralIncomeData>) : void;
    function getReferrals() : Vector.<ReferralIncomeData>;
    function setInviteLink(param1:String) : void;
    function getInviteLink() : String;
    function requestUpdatingReferralsData() : void;
  }
}
