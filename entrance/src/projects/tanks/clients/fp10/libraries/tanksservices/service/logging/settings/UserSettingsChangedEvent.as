package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings {
  import flash.events.Event;

  public class UserSettingsChangedEvent extends Event {
    public static const TYPE:String = "UserSettingsChangedEvent";

    private var _settings:int;

    public function UserSettingsChangedEvent(param1:int) {
      this._settings = param1;
      super(TYPE);
    }

    public function getSettings() : int {
      return this._settings;
    }
  }
}
