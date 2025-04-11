package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class CaptchaAnswerIsIncorrectEvent extends Event {
    public static const EVENT_TYPE:String = "CaptchaAnswerIsIncorrectEvent";

    public function CaptchaAnswerIsIncorrectEvent() {
      super(EVENT_TYPE);
    }
  }
}
