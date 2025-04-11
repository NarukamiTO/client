package alternativa.tanks.model.challenge.battlepass.notifier {
  import flash.events.EventDispatcher;

  public class BattlePassPurchaseServiceImpl extends EventDispatcher implements BattlePassPurchaseService {
    private var _purchased:Boolean = false;

    public function BattlePassPurchaseServiceImpl() {
      super();
    }

    public function isPurchased() : Boolean {
      return this._purchased;
    }

    public function setState(param1:Boolean) : void {
      this._purchased = param1;
      if(this._purchased) {
        dispatchEvent(new BattlePassPurchaseEvent());
      }
    }
  }
}
