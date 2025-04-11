package alternativa.tanks.service.logging {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.panel.PanelInitedEvent;
  import flash.events.EventDispatcher;
  import forms.events.MainButtonBarEvents;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.tanksservices.model.logging.gamescreen.GameScreen;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.*;

  public class UserChangeGameScreenServiceImpl extends EventDispatcher implements UserChangeGameScreenService {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var panelView:IPanelView;

    public function UserChangeGameScreenServiceImpl() {
      super();
      this.panelView = IPanelView(OSGi.getInstance().getService(IPanelView));
      this.panelView.addEventListener(PanelInitedEvent.TYPE,this.onPanelInited);
    }

    private function onPanelInited(param1:PanelInitedEvent) : void {
      this.panelView.getPanel().buttonBar.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,this.onButtonBarButtonClick);
      this.panelView.removeEventListener(PanelInitedEvent.TYPE,this.onPanelInited);
    }

    public function switchGarage() : void {
      if(lobbyLayoutService.getCurrentState() == LayoutState.GARAGE) {
        dispatchEvent(new UserChangedGameScreenEvent(GameScreen.GARAGE,GameScreen.BATTLE));
      } else {
        dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.GARAGE));
      }
    }

    public function switchClan() : void {
      if(lobbyLayoutService.getCurrentState() == LayoutState.CLAN) {
        dispatchEvent(new UserChangedGameScreenEvent(GameScreen.CLAN,GameScreen.BATTLE));
      } else {
        dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.CLAN));
      }
    }

    public function switchBattleSelect() : void {
      if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE_SELECT) {
        dispatchEvent(new UserChangedGameScreenEvent(GameScreen.BATTLE_SELECT,GameScreen.BATTLE));
      } else {
        dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.BATTLE_SELECT));
      }
    }

    public function switchMatchmaking() : void {
    }

    public function returnToBattle() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.BATTLE));
    }

    public function questWindowOpened() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.QUESTS));
    }

    public function exitFromBattleToMatchmaking() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.BATTLE,GameScreen.MATCHMAKING));
    }

    public function exitFromBattleToGarage() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.BATTLE,GameScreen.GARAGE));
    }

    public function exitFromBattleToClan() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.BATTLE,GameScreen.CLAN));
    }

    public function exitFromGame() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.EXIT_GAME));
    }

    public function enterBattle() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.BATTLE));
    }

    public function paymentWindowOpened() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.PAYMENT));
    }

    public function paymentWindowClosed() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.PAYMENT,this.getScreenByCurrentState()));
    }

    public function questWindowClosed() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.QUESTS,this.getScreenByCurrentState()));
    }

    public function friendWindowClosed() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.FRIENDS,this.getScreenByCurrentState()));
    }

    public function settingsWindowClosed() : void {
      dispatchEvent(new UserChangedGameScreenEvent(GameScreen.SETTINGS,this.getScreenByCurrentState()));
    }

    public function showUserStatistics() : void {
      dispatchEvent(new UserChangedGameScreenEvent(this.getScreenByCurrentState(),GameScreen.STATISTICS));
    }

    private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void {
      if([MainButtonBarEvents.BATTLE,MainButtonBarEvents.GARAGE,MainButtonBarEvents.CLOSE,MainButtonBarEvents.QUESTS].indexOf(param1.typeButton) >= 0) {
        return;
      }
      if([MainButtonBarEvents.FRIENDS,MainButtonBarEvents.SETTINGS].indexOf(param1.typeButton) < 0) {
        return;
      }
      var local2:GameScreen = this.getScreenByCurrentState();
      var local3:GameScreen = this.getScreenByButtonType(param1.typeButton);
      dispatchEvent(new UserChangedGameScreenEvent(local2,local3));
    }

    private function getScreenByCurrentState() : GameScreen {
      switch(lobbyLayoutService.getCurrentState()) {
        case LayoutState.BATTLE:
          return GameScreen.BATTLE;
        case LayoutState.BATTLE_SELECT:
          return GameScreen.BATTLE_SELECT;
        case LayoutState.MATCHMAKING:
          return GameScreen.MATCHMAKING;
        case LayoutState.GARAGE:
          return GameScreen.GARAGE;
        case LayoutState.CLAN:
          return GameScreen.CLAN;
        default:
          return GameScreen.BATTLE_SELECT;
      }
    }

    private function getScreenByButtonType(param1:String) : GameScreen {
      switch(param1) {
        case MainButtonBarEvents.FRIENDS:
          return GameScreen.FRIENDS;
        case MainButtonBarEvents.SETTINGS:
          return GameScreen.SETTINGS;
        case MainButtonBarEvents.CLAN:
          return GameScreen.CLAN;
        default:
          return GameScreen.BATTLE_SELECT;
      }
    }
  }
}
