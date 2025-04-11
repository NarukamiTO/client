package alternativa.tanks.model.coin {
  import flash.events.Event;

  public class CoinsChangedEvent extends Event {
    public static const EVENT_TYPE:String = "CoinsChangedEvent";

    public var coins:int = 0;

    public function CoinsChangedEvent(param1:int) {
      super(EVENT_TYPE);
      this.coins = param1;
    }
  }
}
