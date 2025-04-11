package alternativa.tanks.models.tank.support {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.services.battleinput.BattleInputLockType;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.BlurServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class DialogWindowSupport implements AutoClosable {
    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var dialogService:IDialogsService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    public function DialogWindowSupport() {
      super();
      init();
    }

    private static function init() : void {
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.OPEN,onOpenDialogWindow);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,onCloseDialogWindow);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,onBeginLayoutSwitch);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,onEndLayoutSwitch);
      blurService.addEventListener(BlurServiceEvent.CLICK_OVERLAY_BATTLE_CONTENT,onClickOverlayBattleContent);
      if(!lobbyLayoutService.isSwitchInProgress()) {
        onCloseDialogWindow();
      }
    }

    private static function onOpenDialogWindow(param1:DialogWindowsDispatcherServiceEvent = null) : void {
      battleInputService.lock(BattleInputLockType.MODAL_DIALOG);
    }

    private static function onCloseDialogWindow(param1:DialogWindowsDispatcherServiceEvent = null) : void {
      if(!lobbyLayoutService.isWindowOpenOverBattle() && !paymentDisplayService.isPaymentDisplayed()) {
        battleInputService.unlock(BattleInputLockType.MODAL_DIALOG);
        battleService.getBattleView().setFocus();
      }
    }

    private static function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      blurService.blurBattleContent();
      onOpenDialogWindow();
    }

    private static function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(!lobbyLayoutService.isWindowOpenOverBattle()) {
        blurService.unblurBattleContent();
        onCloseDialogWindow();
      }
    }

    private static function onClickOverlayBattleContent(param1:BlurServiceEvent) : void {
      lobbyLayoutService.closePopupOverBattle();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.OPEN,onOpenDialogWindow);
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,onCloseDialogWindow);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,onBeginLayoutSwitch);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,onEndLayoutSwitch);
      blurService.removeEventListener(BlurServiceEvent.CLICK_OVERLAY_BATTLE_CONTENT,onClickOverlayBattleContent);
      blurService.unblurBattleContent();
    }
  }
}
