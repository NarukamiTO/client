package alternativa.tanks.gui.payment.forms.platbox {
  import flash.events.Event;

  public class ProceedPaymentEvent extends Event {
    public static const PROCEED:String = "ProceedPaymentEvent";

    public function ProceedPaymentEvent() {
      super(PROCEED);
    }
  }
}
