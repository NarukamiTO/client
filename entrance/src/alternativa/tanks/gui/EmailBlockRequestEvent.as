package alternativa.tanks.gui {
  import flash.events.Event;

  public class EmailBlockRequestEvent extends Event {
    public static const SEND_VALIDATE_EMAIL_REQUEST_EVENT:String = "ThanksForPurchaseWindowEmailRequestEventSEND_VALIDATE_EMAIL_REQUEST_EVENT";

    public var email:String;

    public function EmailBlockRequestEvent(param1:String, param2:String) {
      super(param1,true,false);
      this.email = param2;
    }
  }
}
