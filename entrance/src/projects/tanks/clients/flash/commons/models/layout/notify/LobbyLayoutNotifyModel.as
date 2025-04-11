package projects.tanks.clients.flash.commons.models.layout.notify {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.commons.models.layout.notify.ILobbyLayoutNotifyModelBase;
  import projects.tanks.client.commons.models.layout.notify.LobbyLayoutNotifyModelBase;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class LobbyLayoutNotifyModel extends LobbyLayoutNotifyModelBase implements ILobbyLayoutNotifyModelBase, ILobbyLayoutNotify, ObjectUnloadListener {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var ymService:YandexMetricaService;

    private static const CHANNEL:String = "LobbyLayoutNotifyModel";
    private static const BATTLE_LOAD_START:String = "BattleLoad:start";
    private static const LOBBY_LOAD_FINISH:String = "LobbyLoad:finish";
    private static const LOBBY_LOAD_START:String = "LobbyLoad:start";
    private static const BATTLE_LOAD_FINISH:String = "BattleLoad:finish";

    private var inProgress:Boolean = false;
    private var origin:LayoutState;
    private var lastState:LayoutState;

    public function LobbyLayoutNotifyModel() {
      super();
    }

    public function beginLayoutSwitch(param1:LayoutState) : void {
      if(param1 != null) {
        this.lastState = param1;
      }
      this.beginSwitch();
    }

    public function endLayoutSwitch(param1:LayoutState, param2:LayoutState) : void {
      this.origin = param1;
      this.lastState = param2;
      this.endSwitch();
    }

    public function layoutSwitchPredicted() : void {
      modalLoaderService.show();
    }

    public function cancelPredictedLayoutSwitch() : void {
      this.endSwitch();
      modalLoaderService.hideForcibly();
      loaderWindowService.hideForcibly();
    }

    public function isSwitchInProgress() : Boolean {
      return this.inProgress;
    }

    public function getCurrentState() : LayoutState {
      return this.lastState;
    }

    public function inBattle() : Boolean {
      return this.origin == LayoutState.BATTLE;
    }

    private function beginSwitch() : void {
      if(!this.inProgress) {
        this.inProgress = true;
        ymService.reachGoalIfPlayerIsNewbie(this.lastState == LayoutState.BATTLE && !this.origin ? BATTLE_LOAD_START : LOBBY_LOAD_START);
        if(this.lastState == LayoutState.GARAGE || this.lastState == LayoutState.CLAN || this.lastState == LayoutState.MATCHMAKING || this.lastState == LayoutState.BATTLE_SELECT) {
          modalLoaderService.show();
        } else if(this.lastState != LayoutState.BATTLE || !lobbyLayoutService.isBattleReady()) {
          if(!modalLoaderService.isVisible()) {
            loaderWindowService.show();
          }
        }
        lobbyLayoutService.dispatchEvent(new LobbyLayoutServiceEvent(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.lastState));
      }
    }

    private function endSwitch() : void {
      if(this.inProgress) {
        this.inProgress = false;
        ymService.reachGoalIfPlayerIsNewbie(this.inBattle() && this.lastState == LayoutState.BATTLE ? BATTLE_LOAD_FINISH : LOBBY_LOAD_FINISH);
        if(this.lastState != LayoutState.BATTLE) {
          loaderWindowService.hide();
          modalLoaderService.hideForcibly();
        }
        lobbyLayoutService.dispatchEvent(new LobbyLayoutServiceEvent(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.lastState));
      }
    }

    public function objectUnloaded() : void {
    }
  }
}
