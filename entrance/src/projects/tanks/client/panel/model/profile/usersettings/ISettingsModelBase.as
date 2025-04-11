package projects.tanks.client.panel.model.profile.usersettings {
  import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;

  public interface ISettingsModelBase {
    function openAntiAddictionSettings(param1:PersonalMessageReceiveMode, param2:String, param3:String) : void;
    function openSettings(param1:PersonalMessageReceiveMode) : void;
  }
}
