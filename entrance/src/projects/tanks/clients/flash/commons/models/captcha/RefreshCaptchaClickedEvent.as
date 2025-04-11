package projects.tanks.clients.flash.commons.models.captcha {
  import flash.events.Event;

  public class RefreshCaptchaClickedEvent extends Event {
    public static const CLICKED:String = "RefreshCaptchaClickedEvent.CLICKED";

    public function RefreshCaptchaClickedEvent() {
      super(CLICKED,true);
    }
  }
}
