package alternativa.tanks.model.challenge.battlepass.notifier {
  import flash.events.Event;

  public class BattlePassPurchaseEvent extends Event {
    public static const PURCHASE:String = "BattlePassPurchaseEvent.PURCHASE";

    public function BattlePassPurchaseEvent() {
      super(PURCHASE,true);
    }
  }
}
