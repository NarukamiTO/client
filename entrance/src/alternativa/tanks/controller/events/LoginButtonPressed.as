package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class LoginButtonPressed extends Event {
    public static const EVENT_TYPE:String = "LoginButtonPressed.EVENT_TYPE";

    public function LoginButtonPressed() {
      super(EVENT_TYPE);
    }
  }
}
