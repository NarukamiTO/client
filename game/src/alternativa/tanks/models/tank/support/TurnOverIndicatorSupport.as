package alternativa.tanks.models.tank.support {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.events.reload.ReloadActivateEvent;
  import alternativa.tanks.battle.events.reload.ReloadDeactivateEvent;
  import alternativa.tanks.battle.events.suicide.SuicideActivationEvent;
  import alternativa.tanks.battle.events.suicide.SuicideDeactivationEvent;
  import alternativa.tanks.models.battle.gui.indicators.TurnOverIndicator;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class TurnOverIndicatorSupport implements AutoClosable, BattleEventListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var turnOverIndicator:TurnOverIndicator;
    private var isSuiciding:Boolean;
    private var isRearmorReloading:Boolean;
    private var isPausing:Boolean;
    private var shouldBeShown:Boolean;

    public function TurnOverIndicatorSupport() {
      super();
      this.turnOverIndicator = new TurnOverIndicator();
      this.addEventHandlers();
      this.isSuiciding = false;
      this.isRearmorReloading = false;
      this.isPausing = false;
      this.shouldBeShown = false;
    }

    public function shouldShow() : void {
      this.shouldBeShown = true;
      this.processIndicatorVisibility();
    }

    public function hide() : void {
      this.shouldBeShown = false;
      this.turnOverIndicator.hide();
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is SuicideActivationEvent) {
        this.isSuiciding = true;
      } else if(param1 is SuicideDeactivationEvent) {
        this.isSuiciding = false;
      } else if(param1 is ReloadActivateEvent) {
        this.isRearmorReloading = true;
      } else if(param1 is ReloadDeactivateEvent) {
        this.isRearmorReloading = false;
      } else if(param1 is PauseActivationEvent) {
        this.isPausing = true;
      } else if(param1 is PauseDeactivationEvent) {
        this.isPausing = false;
      }
      this.processIndicatorVisibility();
    }

    private function processIndicatorVisibility() : void {
      if(this.shouldBeShown && this.canBeShown()) {
        this.turnOverIndicator.show();
      } else {
        this.turnOverIndicator.hide();
      }
    }

    private function canBeShown() : Boolean {
      return !this.isRearmorReloading && !this.isSuiciding && !lobbyLayoutService.isWindowOpenOverBattle() && !this.isPausing;
    }

    private function addEventHandlers() : void {
      battleEventDispatcher.addBattleEventListener(SuicideActivationEvent,this);
      battleEventDispatcher.addBattleEventListener(SuicideDeactivationEvent,this);
      battleEventDispatcher.addBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadDeactivateEvent,this);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.handleBattleEvent);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.handleBattleEvent);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.handleBattleEvent);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.handleBattleEvent);
    }

    private function removeEventHandlers() : void {
      battleEventDispatcher.removeBattleEventListener(SuicideActivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(SuicideDeactivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadDeactivateEvent,this);
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.handleBattleEvent);
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.handleBattleEvent);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.handleBattleEvent);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.handleBattleEvent);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.removeEventHandlers();
      this.turnOverIndicator.destroy();
      this.turnOverIndicator = null;
      this.isSuiciding = false;
      this.isRearmorReloading = false;
      this.isPausing = false;
      this.shouldBeShown = false;
    }
  }
}
