package alternativa.tanks.model.buyproabonement {
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.view.battleinfo.BattleInfoViewEvent;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.buyabonement.BuyProAbonementModelBase;
  import projects.tanks.client.battleselect.model.buyabonement.IBuyProAbonementModelBase;

  [ModelInfo]
  public class BuyProAbonementModel extends BuyProAbonementModelBase implements IBuyProAbonementModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    public function BuyProAbonementModel() {
      super();
    }

    public function objectLoaded() : void {
      battleInfoFormService.addEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,getFunctionWrapper(this.onBuyProSubscription));
    }

    public function objectUnloaded() : void {
      battleInfoFormService.removeEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,getFunctionWrapper(this.onBuyProSubscription));
    }

    public function onBuyProSubscription(param1:BattleInfoViewEvent) : void {
      server.selectProBattlePass();
    }
  }
}
