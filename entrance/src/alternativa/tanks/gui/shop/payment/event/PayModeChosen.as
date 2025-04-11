package alternativa.tanks.gui.shop.payment.event {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeChosen extends Event {
    public static const EVENT_TYPE:String = "PayModeChosenEVENT";

    public var payMode:IGameObject;

    public function PayModeChosen(param1:IGameObject) {
      super(EVENT_TYPE,true);
      this.payMode = param1;
    }
  }
}
