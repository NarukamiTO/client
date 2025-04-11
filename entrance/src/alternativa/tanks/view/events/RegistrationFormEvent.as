package alternativa.tanks.view.events {
  import flash.events.Event;

  public class RegistrationFormEvent extends Event {
    public static const CLICK_REGISTRATION_BUTTON:String = "RegistrationFormEvent.CLICK_REGISTRATION_BUTTON";

    public function RegistrationFormEvent() {
      super(CLICK_REGISTRATION_BUTTON,true);
    }
  }
}
