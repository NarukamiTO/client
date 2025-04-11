package alternativa.tanks.model.chat {
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingEnum;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import platform.client.fp10.core.type.AutoClosable;

  public class ChatSettingsTracker implements AutoClosable {
    [Inject]
    public static var settingsService:ISettingsService;

    private var chat:ShowChat;

    public function ChatSettingsTracker(param1:ShowChat) {
      super();
      this.chat = param1;
      param1.setShowChat(settingsService.showChat);
      settingsService.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }

    private function onSettingsAccepted(param1:SettingsServiceEvent) : void {
      if(param1.getSetting() == SettingEnum.SHOW_CHAT) {
        this.chat.setShowChat(settingsService.showChat);
      }
    }

    public function close() : void {
      this.chat = null;
      settingsService.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }
  }
}
