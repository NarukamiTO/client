package alternativa.tanks.gui.confirm {
  import flash.events.Event;

  public class ConfirmAlertEvent extends Event {
    public static const BUY_ITEM:String = "ConfirmAlertEventBuyItem";

    public var cost:int = 0;

    public function ConfirmAlertEvent(param1:int) {
      super(BUY_ITEM,true);
      this.cost = param1;
    }
  }
}
