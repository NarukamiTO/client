package alternativa.tanks.gui.shop.payment.event {
  import flash.events.Event;

  public class ApproveFormEvent extends Event {
    public static const EVENT_TYPE:String = "ApproveFormEvent";

    public function ApproveFormEvent() {
      super(EVENT_TYPE,true);
    }
  }
}
