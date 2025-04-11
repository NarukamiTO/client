package alternativa.tanks.service.paymentcomplete {
  import flash.events.Event;

  public class PaymentCompleteEvent extends Event {
    public static const COMPLETED:String = "PaymentCompleteEvent.COMPLETED";

    public function PaymentCompleteEvent() {
      super(COMPLETED);
    }
  }
}
