package alternativa.tanks.gui.payment.events {
  import flash.events.Event;

  public class PaymentFormEvent extends Event {
    public static var PROCEED:String = "PaymentFormEventProceed";
    public static var SUBSYSTEM_SELECTED:String = "PaymentFormEventSubsystemSelected";

    public function PaymentFormEvent(param1:String) {
      super(param1,true,false);
    }
  }
}
