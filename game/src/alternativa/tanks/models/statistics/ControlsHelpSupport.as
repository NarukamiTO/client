package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.gui.help.ControlsHelper;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class ControlsHelpSupport implements AutoClosable {
    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var controlsHelper:ControlsHelper;

    public function ControlsHelpSupport() {
      super();
      this.init();
    }

    private static function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state == LayoutState.BATTLE) {
        unregisterControlsHelpScreen();
      }
    }

    private static function unregisterControlsHelpScreen() : void {
      helpService.unregisterHelper(ControlsHelper.GROUP_ID,ControlsHelper.HELPER_ID);
    }

    private function init() : void {
      this.controlsHelper = new ControlsHelper();
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,onBeginLayoutSwitch);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state == LayoutState.BATTLE) {
        this.registerControlsHelpScreen();
      }
    }

    private function registerControlsHelpScreen() : void {
      helpService.registerHelper(ControlsHelper.GROUP_ID,ControlsHelper.HELPER_ID,this.controlsHelper,true);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,onBeginLayoutSwitch);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
      unregisterControlsHelpScreen();
      this.controlsHelper = null;
    }
  }
}
