package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.gui.statistics.fps.FPSText;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingEnum;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.utils.removeDisplayObject;
  import platform.client.fp10.core.type.AutoClosable;

  public class FpsIndicatorToggleSupport implements AutoClosable {
    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    private var fpsIndicator:FPSText;

    public function FpsIndicatorToggleSupport(param1:FPSText) {
      super();
      this.fpsIndicator = param1;
      settingsService.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }

    private function onSettingsAccepted(param1:SettingsServiceEvent) : void {
      if(param1.getSetting() != SettingEnum.SHOW_FPS) {
        return;
      }
      if(settingsService.showFPS) {
        battleGuiService.getGuiContainer().addChild(this.fpsIndicator);
      } else {
        removeDisplayObject(this.fpsIndicator);
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.fpsIndicator = null;
      settingsService.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }
  }
}
