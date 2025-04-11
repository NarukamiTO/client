package alternativa.tanks.service.settings {
  import flash.events.Event;

  public class SettingsServiceEvent extends Event {
    public static const SETTINGS_CHANGED:String = "SettingsServiceEvent.SETTINGS_CHANGED";

    private var setting:SettingEnum;

    public function SettingsServiceEvent(param1:String, param2:SettingEnum) {
      super(param1,true,false);
      this.setting = param2;
    }

    public function getSetting() : SettingEnum {
      return this.setting;
    }
  }
}
