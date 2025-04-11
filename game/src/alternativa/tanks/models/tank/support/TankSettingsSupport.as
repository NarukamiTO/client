package alternativa.tanks.models.tank.support {
  import alternativa.tanks.battle.objects.tank.controllers.LocalChassisController;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import flash.events.Event;
  import platform.client.fp10.core.type.AutoClosable;

  public class TankSettingsSupport implements AutoClosable {
    [Inject]
    public static var settings:ISettingsService;

    private var controller:LocalChassisController;

    public function TankSettingsSupport(param1:LocalChassisController) {
      super();
      this.controller = param1;
      settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }

    private function onSettingsAccepted(param1:Event) : void {
      this.controller.setReversedBackTurn(settings.inverseBackDriving);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.controller = null;
      settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccepted);
    }
  }
}
