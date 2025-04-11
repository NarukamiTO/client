package alternativa.tanks.controller.events.logging {
  import flash.events.Event;

  public class RegistrationUXNavigationFinishEvent extends Event {
    public static const NAVIGATION_FINISH:String = "RegistrationUXNavigationFinishEvent";

    public function RegistrationUXNavigationFinishEvent() {
      super(NAVIGATION_FINISH);
    }
  }
}
