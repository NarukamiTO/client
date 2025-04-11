package alternativa.tanks.controller.events.logging {
  import flash.events.Event;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXScreen;

  public class RegistrationUXNavigationStartEvent extends Event {
    public static const NAVIGATION_START:String = "RegistrationUXNavigationStartEvent";

    private var _screen:RegistrationUXScreen;

    public function RegistrationUXNavigationStartEvent(param1:RegistrationUXScreen) {
      this._screen = param1;
      super(NAVIGATION_START);
    }

    public function get screen() : RegistrationUXScreen {
      return this._screen;
    }
  }
}
