package alternativa.tanks.model.referrals.notifier {
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierServiceEvent;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.referrals.notification.INewReferralsNotifierModelBase;
  import projects.tanks.client.panel.model.referrals.notification.NewReferralsNotifierModelBase;

  [ModelInfo]
  public class NewReferralsNotifierModel extends NewReferralsNotifierModelBase implements INewReferralsNotifierModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var newReferralsNotifierService:NewReferralsNotifierService;

    public function NewReferralsNotifierModel() {
      super();
    }

    public function objectLoadedPost() : void {
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.REQUEST_NEW_REFERRALS_COUNT,getFunctionWrapper(this.requestNewReferralsCount));
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.RESET_NEW_REFERRALS_COUNT,getFunctionWrapper(this.resetNewReferralsCount));
    }

    private function resetNewReferralsCount(param1:NewReferralsNotifierServiceEvent) : void {
      server.resetNewReferralsCount();
    }

    private function requestNewReferralsCount(param1:NewReferralsNotifierServiceEvent) : void {
      server.requestNewReferralsCount();
    }

    public function objectUnloaded() : void {
      newReferralsNotifierService.removeEventListener(NewReferralsNotifierServiceEvent.REQUEST_NEW_REFERRALS_COUNT,getFunctionWrapper(this.requestNewReferralsCount));
      newReferralsNotifierService.removeEventListener(NewReferralsNotifierServiceEvent.RESET_NEW_REFERRALS_COUNT,getFunctionWrapper(this.resetNewReferralsCount));
    }

    public function notifyReferralAdded(param1:int) : void {
      newReferralsNotifierService.notifyReferralAdded(param1);
    }

    public function notifyNewReferralsCountUpdated(param1:int) : void {
      newReferralsNotifierService.newReferralsCountUpdated(param1);
    }
  }
}
