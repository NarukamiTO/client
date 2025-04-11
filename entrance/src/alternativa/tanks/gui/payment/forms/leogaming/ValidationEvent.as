package alternativa.tanks.gui.payment.forms.leogaming {
  import flash.events.Event;

  public class ValidationEvent extends Event {
    public static const VALID:String = "ValidationEvent.VALID";
    public static const INVALID:String = "ValidationEvent.INVALID";

    public function ValidationEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
