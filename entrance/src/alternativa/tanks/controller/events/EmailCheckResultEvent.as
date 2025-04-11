package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class EmailCheckResultEvent extends Event {
    public static const EMAIL_IS_INVALID:String = "EmailCheckResultEvent.EMAIL_IS_INVALID";
    public static const EMAIL_IS_BUSY:String = "EmailCheckResultEvent.EMAIL_IS_BUSY";
    public static const EMAIL_IS_FREE:String = "EmailCheckResultEvent.EMAIL_IS_FREE";
    public static const EMAIL_DOMAIN_IS_FORBIDDEN:String = "EmailCheckResultEvent.EMAIL_DOMAIN_IS_FORBIDDEN";

    public function EmailCheckResultEvent(param1:String) {
      super(param1);
    }
  }
}
