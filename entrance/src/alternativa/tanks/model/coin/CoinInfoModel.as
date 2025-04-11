package alternativa.tanks.model.coin {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.coin.CoinInfoModelBase;
  import projects.tanks.client.panel.model.coin.ICoinInfoModelBase;

  [ModelInfo]
  public class CoinInfoModel extends CoinInfoModelBase implements ICoinInfoModelBase, ObjectLoadListener {
    [Inject]
    public static var coinInfoService:CoinInfoService;

    public function CoinInfoModel() {
      super();
    }

    public function objectLoaded() : void {
      coinInfoService.enabled = getInitParam().enabled;
      coinInfoService.setCoins(getInitParam().coins);
    }

    public function setCoins(param1:int) : void {
      coinInfoService.setCoins(param1);
    }

    public function changeBy(param1:int) : void {
      coinInfoService.changeBy(param1);
    }
  }
}
