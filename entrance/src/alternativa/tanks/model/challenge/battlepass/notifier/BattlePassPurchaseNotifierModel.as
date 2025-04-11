package alternativa.tanks.model.challenge.battlepass.notifier {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.battlepass.purchasenotifier.BattlePassPurchaseNotifierModelBase;
  import projects.tanks.client.panel.model.battlepass.purchasenotifier.IBattlePassPurchaseNotifierModelBase;

  [ModelInfo]
  public class BattlePassPurchaseNotifierModel extends BattlePassPurchaseNotifierModelBase implements IBattlePassPurchaseNotifierModelBase, ObjectLoadListener {
    [Inject]
    public static var battlePassPurchaseService:BattlePassPurchaseService;

    public function BattlePassPurchaseNotifierModel() {
      super();
    }

    public function objectLoaded() : void {
      battlePassPurchaseService.setState(getInitParam().purchased);
    }

    public function battlePassPurchased() : void {
      battlePassPurchaseService.setState(true);
    }
  }
}
