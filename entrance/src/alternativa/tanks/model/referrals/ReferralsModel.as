package alternativa.tanks.model.referrals {
  import alternativa.tanks.service.referrals.ReferralsService;
  import alternativa.tanks.service.referrals.ReferralsServiceEvent;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.referrals.IReferralsModelBase;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
  import projects.tanks.client.panel.model.referrals.ReferralsModelBase;

  [ModelInfo]
  public class ReferralsModel extends ReferralsModelBase implements IReferralsModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var referralService:ReferralsService;

    public function ReferralsModel() {
      super();
    }

    public function objectLoadedPost() : void {
      referralService.setInviteLink(getInitParam().inviteLink);
      referralService.addEventListener(ReferralsServiceEvent.UPDATE_DATA_REQUEST,getFunctionWrapper(this.onUpdateDataRequest));
    }

    private function onUpdateDataRequest(param1:ReferralsServiceEvent) : void {
      server.updateReferralsData();
    }

    public function updateData(param1:Vector.<ReferralIncomeData>) : void {
      referralService.updateReferralsData(param1);
    }

    public function objectUnloaded() : void {
      referralService.removeEventListener(ReferralsServiceEvent.UPDATE_DATA_REQUEST,getFunctionWrapper(this.onUpdateDataRequest));
    }
  }
}
