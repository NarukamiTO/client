package alternativa.tanks.service.referrals {
  import flash.events.EventDispatcher;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;

  public class ReferralsServiceImpl extends EventDispatcher implements ReferralsService {
    private var referrals:Vector.<ReferralIncomeData>;
    private var link:String;

    public function ReferralsServiceImpl() {
      super();
    }

    public function updateReferralsData(param1:Vector.<ReferralIncomeData>) : void {
      this.referrals = param1;
      dispatchEvent(new ReferralsServiceEvent(ReferralsServiceEvent.DATA_UPDATED));
    }

    public function getReferrals() : Vector.<ReferralIncomeData> {
      return this.referrals;
    }

    public function setInviteLink(param1:String) : void {
      this.link = param1;
    }

    public function getInviteLink() : String {
      return this.link;
    }

    public function requestUpdatingReferralsData() : void {
      dispatchEvent(new ReferralsServiceEvent(ReferralsServiceEvent.UPDATE_DATA_REQUEST));
    }
  }
}
