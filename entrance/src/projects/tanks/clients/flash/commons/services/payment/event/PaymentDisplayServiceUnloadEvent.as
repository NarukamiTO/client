package projects.tanks.clients.flash.commons.services.payment.event {
  import flash.events.Event;

  public class PaymentDisplayServiceUnloadEvent extends Event {
    public static const UNLOAD_PAYMENT:String = "PaymentDisplayServiceEventUNLOAD_PAYMENT";

    public function PaymentDisplayServiceUnloadEvent() {
      super(UNLOAD_PAYMENT);
    }
  }
}
