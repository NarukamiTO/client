package alternativa.tanks.battle.notificationpausefinish {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class NotificationEndsPauseSupport implements AutoClosable, BattleEventListener, LogicUnit {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const NOTIFICATION_ENDS_PAUSE_TIME_IN_SEC:int = 60;

    private var _idleTimeoutEndTime:int;
    private var _alert:EndsPauseAlert;
    private var _pauseActivate:Boolean;

    public function NotificationEndsPauseSupport() {
      super();
      this.init();
    }

    private static function needShowAlert() : Boolean {
      return !lobbyLayoutService.isSwitchInProgress() && Boolean(lobbyLayoutService.isWindowOpenOverBattle());
    }

    private static function closeModalWindowsOverBattle() : void {
      var local1:LayoutState = lobbyLayoutService.getCurrentState();
      if(local1 != LayoutState.BATTLE) {
        lobbyLayoutService.returnToBattle();
      }
    }

    private function init() : void {
      battleEventDispatcher.addBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is PauseActivationEvent) {
        this.onPauseActivated(PauseActivationEvent(param1));
      } else if(param1 is PauseDeactivationEvent) {
        this.onPauseDeactivated();
      }
    }

    private function onPauseActivated(param1:PauseActivationEvent) : void {
      if(this._pauseActivate) {
        return;
      }
      this._pauseActivate = true;
      this._idleTimeoutEndTime = getTimer() + param1.idleTimeLeft;
      battleService.getBattleRunner().addLogicUnit(this);
    }

    private function onPauseDeactivated() : void {
      if(!this._pauseActivate) {
        return;
      }
      this._pauseActivate = false;
      battleService.getBattleRunner().removeLogicUnit(this);
      this.destroyAlert();
    }

    private function destroyAlert() : void {
      if(this.hasAlert()) {
        this._alert.removeEventListener(NotificationEndsPausedAlertEvent.RETURN_TO_BATTLE,this.onReturnToBattle);
        this._alert.removeEventListener(NotificationEndsPausedAlertEvent.CLOSE_ALERT,this.onCloseAlert);
        this._alert.destroy();
        this._alert = null;
      }
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:int = (this._idleTimeoutEndTime - param1) / 1000;
      if(local3 <= NOTIFICATION_ENDS_PAUSE_TIME_IN_SEC) {
        if(this.hasAlert()) {
          this._alert.seconds = Math.max(local3,0);
        } else if(needShowAlert()) {
          this.createAlert(local3);
        }
      }
    }

    private function hasAlert() : Boolean {
      return this._alert != null;
    }

    private function createAlert(param1:int) : void {
      this._alert = new EndsPauseAlert();
      this._alert.addEventListener(NotificationEndsPausedAlertEvent.RETURN_TO_BATTLE,this.onReturnToBattle);
      this._alert.addEventListener(NotificationEndsPausedAlertEvent.CLOSE_ALERT,this.onCloseAlert);
      this._alert.seconds = param1;
      this._alert.show();
    }

    private function onCloseAlert(param1:NotificationEndsPausedAlertEvent = null) : void {
      this.onPauseDeactivated();
    }

    private function onReturnToBattle(param1:NotificationEndsPausedAlertEvent) : void {
      dialogWindowsDispatcherService.forciblyClose();
      closeModalWindowsOverBattle();
      this.onPauseDeactivated();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.destroyAlert();
      battleEventDispatcher.removeBattleEventListener(PauseActivationEvent,this);
      battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
    }
  }
}
