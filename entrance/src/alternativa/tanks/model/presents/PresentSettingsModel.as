package alternativa.tanks.model.presents {
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingEnum;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.presents.IPresentsSettingsModelBase;
  import projects.tanks.client.panel.model.presents.PresentsSettingsModelBase;

  [ModelInfo]
  public class PresentSettingsModel extends PresentsSettingsModelBase implements IPresentsSettingsModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var settingsService:ISettingsService;

    public function PresentSettingsModel() {
      super();
    }

    public function objectLoaded() : void {
      settingsService.receivePresents = getInitParam().receivePresentsEnabled;
      settingsService.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,getFunctionWrapper(this.settingsChanged));
    }

    public function objectUnloaded() : void {
      settingsService.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,getFunctionWrapper(this.settingsChanged));
    }

    private function settingsChanged(param1:SettingsServiceEvent) : void {
      if(param1.getSetting() == SettingEnum.RECEIVE_PRESENTS) {
        server.setReceivePresents(settingsService.receivePresents);
      }
    }
  }
}
