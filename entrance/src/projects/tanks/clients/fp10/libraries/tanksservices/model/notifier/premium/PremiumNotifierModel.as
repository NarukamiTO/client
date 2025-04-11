package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.premium {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.tanksservices.model.notifier.premium.IPremiumNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;

  [ModelInfo]
  public class PremiumNotifierModel extends PremiumNotifierModelBase implements IPremiumNotifierModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var premiumService:PremiumService;

    public function PremiumNotifierModel() {
      super();
    }

    public function updateTimeLeft(param1:int) : void {
      premiumService.updateTimeLeft(param1);
    }

    public function objectLoaded() : void {
      premiumService.updateTimeLeft(getInitParam().lifeTimeInSeconds);
    }

    public function objectUnloaded() : void {
      premiumService.destroy();
    }
  }
}
