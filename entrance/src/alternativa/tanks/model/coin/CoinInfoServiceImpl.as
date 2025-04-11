package alternativa.tanks.model.coin {
  import flash.events.EventDispatcher;

  public class CoinInfoServiceImpl extends EventDispatcher implements CoinInfoService {
    private var coins:int;
    private var _enabled:Boolean;

    public function CoinInfoServiceImpl() {
      super();
    }

    public function getCoins() : int {
      return this.coins;
    }

    public function setCoins(param1:int) : void {
      if(this.coins != param1) {
        this.coins = param1;
        dispatchEvent(new CoinsChangedEvent(param1));
      }
    }

    public function changeBy(param1:int) : void {
      var local2:int = Math.max(this.coins + param1,0);
      this.setCoins(local2);
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }
  }
}
