package alternativa.tanks.models.tank.support {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.events.ShowPauseIndicatorEvent;
  import alternativa.tanks.battle.events.reload.ReloadActivateEvent;
  import alternativa.tanks.battle.events.reload.ReloadDeactivateEvent;
  import alternativa.tanks.battle.events.suicide.SuicideActivationEvent;
  import alternativa.tanks.battle.events.suicide.SuicideDeactivationEvent;
  import alternativa.tanks.models.tank.IdleKickTime;
  import alternativa.tanks.models.tank.pause.ITankPause;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class PauseSupport implements AutoClosable, BattleEventListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var dialogsService:IDialogsService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    [Inject]
    public static var fullscreenStateService:FullscreenStateService;

    [Inject]
    public static var keysBindingService:KeysBindingService;

    private var _localUser:IGameObject;
    private var _idleKickTime:IdleKickTime;
    private var _paused:Boolean;
    private var _suicideEnable:Boolean;
    private var _rearmorEnable:Boolean;
    private var _isManuallyInclusion:Boolean;

    public function PauseSupport(param1:IGameObject, param2:IdleKickTime, param3:Boolean) {
      super();
      this._localUser = param1;
      this._idleKickTime = param2;
      this._paused = param3;
      this.init();
    }

    private function init() : void {
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      display.stage.addEventListener(Event.ACTIVATE,this.onFocusInFlash);
      display.stage.addEventListener(Event.DEACTIVATE,this.onFocusOutFlash);
      battleEventDispatcher.addBattleEventListener(SuicideActivationEvent,this);
      battleEventDispatcher.addBattleEventListener(SuicideDeactivationEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.addBattleEventListener(ReloadDeactivateEvent,this);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.onOpenDialogWindow);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.onCloseDialogWindow);
      battleGUIService.getViewportContainer().addEventListener(MouseEvent.CLICK,this.onClickViewportContainer);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      if(this._paused) {
        this.handleKeyWhenPaused(param1);
      } else {
        this.handleKeyWhenUnpaused(param1);
      }
    }

    private function handleKeyWhenPaused(param1:KeyboardEvent) : void {
      if(param1.keyCode != Keyboard.ALTERNATE && !param1.altKey && !battleInputService.isInputLocked()) {
        this.manualDisablePause();
      }
    }

    private function manualDisablePause() : void {
      this._isManuallyInclusion = false;
      this.disablePause();
    }

    private function disablePause() : void {
      var local1:ITankPause = null;
      if(!this._paused || this._isManuallyInclusion || Boolean(lobbyLayoutService.isWindowOpenOverBattle())) {
        return;
      }
      this._paused = false;
      battleService.getBattleView().setFocus();
      if(this._localUser.hasModel(ITankPause)) {
        local1 = ITankPause(this._localUser.adapt(ITankPause));
        local1.disablePause();
        battleEventDispatcher.dispatchEvent(new PauseDeactivationEvent());
      }
    }

    private function handleKeyWhenUnpaused(param1:KeyboardEvent) : void {
      var local2:GameActionEnum = null;
      if(!battleInputService.isInputLocked() && !this._suicideEnable && !this._rearmorEnable) {
        local2 = keysBindingService.getBindingAction(param1.keyCode);
        if(local2 == GameActionEnum.BATTLE_PAUSE) {
          this._isManuallyInclusion = true;
          this.enablePause();
        }
      }
    }

    private function enablePause(param1:Boolean = true) : void {
      if(this._paused) {
        return;
      }
      this._paused = true;
      var local2:ITankPause = ITankPause(this._localUser.adapt(ITankPause));
      local2.enablePause();
      battleEventDispatcher.dispatchEvent(new PauseActivationEvent(this._idleKickTime.getTimeLeft()));
      if(param1) {
        battleEventDispatcher.dispatchEvent(new ShowPauseIndicatorEvent(this._idleKickTime.getTimeLeft()));
      }
    }

    private function onOpenDialogWindow(param1:DialogWindowsDispatcherServiceEvent) : void {
      this.enablePause(false);
    }

    private function onCloseDialogWindow(param1:DialogWindowsDispatcherServiceEvent) : void {
      this.disablePause();
    }

    private function onFocusInFlash(param1:Event) : void {
      this.disablePause();
    }

    private function onFocusOutFlash(param1:Event) : void {
      if(!fullscreenStateService.isFullscreen()) {
        this.enablePause();
      }
    }

    private function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.enablePause(false);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(!lobbyLayoutService.isWindowOpenOverBattle() && Boolean(lobbyLayoutService.inBattle())) {
        this.disablePause();
      }
    }

    private function onClickViewportContainer(param1:MouseEvent) : void {
      if(this._paused && this._isManuallyInclusion) {
        this.manualDisablePause();
      }
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is SuicideActivationEvent) {
        this._suicideEnable = true;
      } else if(param1 is SuicideDeactivationEvent) {
        this._suicideEnable = false;
      } else if(param1 is ReloadActivateEvent) {
        this._rearmorEnable = true;
        this.manualDisablePause();
      } else if(param1 is ReloadDeactivateEvent) {
        this._rearmorEnable = false;
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      display.stage.removeEventListener(Event.ACTIVATE,this.onFocusInFlash);
      display.stage.removeEventListener(Event.DEACTIVATE,this.onFocusOutFlash);
      battleEventDispatcher.removeBattleEventListener(SuicideActivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(SuicideDeactivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadActivateEvent,this);
      battleEventDispatcher.removeBattleEventListener(ReloadDeactivateEvent,this);
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.onOpenDialogWindow);
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.onCloseDialogWindow);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
      battleGUIService.getViewportContainer().removeEventListener(MouseEvent.CLICK,this.onClickViewportContainer);
      this._localUser = null;
    }
  }
}
