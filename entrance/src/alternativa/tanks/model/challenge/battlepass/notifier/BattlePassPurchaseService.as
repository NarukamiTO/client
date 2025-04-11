package alternativa.tanks.model.challenge.battlepass.notifier {
  import flash.events.IEventDispatcher;

  public interface BattlePassPurchaseService extends IEventDispatcher {
    function isPurchased() : Boolean;
    function setState(param1:Boolean) : void;
  }
}
