package alternativa.tanks.gui.settings.tabs.account {
  import alternativa.tanks.gui.settings.SettingEvent;

  public class AccountSettingsEvent extends SettingEvent {
    public static const CHECK_PASSWORD:String = "AccountSettingsEventCheckPassword";
    public static const CHANGE_PASSWORD_BY_EMAIL:String = "AccountSettingsEventChangePasswordByEmail";
    public static const SET_EMAIL:String = "AccountSettingsEventSetEmail";
    public static const CHANGE_PASSWORD:String = "AccountSettingsEventChangePassword";
    public static const SET_ANTI_ADDICTION:String = "AccountSettingsEventSetAntiAddiction";

    public function AccountSettingsEvent(param1:String) {
      super(param1);
    }
  }
}
