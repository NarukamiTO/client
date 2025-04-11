package projects.tanks.clients.flash.commons.services.layout {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.startup.StartupSettings;
  import flash.events.EventDispatcher;
  import flash.external.ExternalInterface;
  import flash.net.SharedObject;
  import platform.client.fp10.core.type.IGameObject;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.models.layout.ILobbyLayout;
  import projects.tanks.clients.flash.commons.models.layout.notify.ILobbyLayoutNotify;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import services.alertservice.Alert;
  import services.alertservice.AlertAnswer;

  public class LobbyLayoutService extends EventDispatcher implements ILobbyLayoutService {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var partnersService:IPartnerService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    private var serviceGameObject:IGameObject;
    private var battleReady:Boolean;

    public function LobbyLayoutService() {
      super();
    }

    private static function showExitFromGameAlert() : void {
      alertService.showAlertById(Alert.ALERT_QUIT);
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,onQuitGameDialogButtonPressed);
    }

    private static function onQuitGameDialogButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,onQuitGameDialogButtonPressed);
      if(param1.typeButton == AlertAnswer.YES) {
        userChangeGameScreenService.exitFromGame();
        clearHash();
        if(ExternalInterface.available) {
          ExternalInterface.call("goToMainPage");
        }
        if(StartupSettings.isDesktop) {
          StartupSettings.closeApplication();
        }
      }
    }

    private static function clearHash() : void {
      var local1:SharedObject = storageService.getStorage();
      local1.data.userHash = null;
      local1.flush();
    }

    public function showGarage() : void {
      userChangeGameScreenService.switchGarage();
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).showGarage();
    }

    public function showBattleSelect() : void {
      userChangeGameScreenService.switchBattleSelect();
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).showBattleSelect();
    }

    public function showMatchmaking() : void {
      userChangeGameScreenService.switchMatchmaking();
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).showMatchmaking();
    }

    public function showBattleLobby() : void {
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).showBattleLobby();
    }

    public function showClan() : void {
      userChangeGameScreenService.switchClan();
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).showClan();
    }

    public function exitFromBattle() : void {
      if(battleInfoService.isSpectatorMode()) {
        this.exitFromBattleWithoutNotify();
      } else {
        this.showExitFromBattleAlert();
      }
    }

    private function showExitFromBattleAlert() : void {
      var local1:String = this.getTextForExitFromBattleAlert();
      alertService.showAlert(local1,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
    }

    public function exitFromBattleToGarageThroughAlert() : void {
      this.showExitFromBattleToGarageAlert();
    }

    private function showExitFromBattleToGarageAlert() : void {
      var local1:String = this.getTextForExitFromBattleAlert();
      alertService.showAlert(local1,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleToGarageDialogButtonPressed);
    }

    private function getTextForExitFromBattleAlert() : String {
      if(!userInfoService.isOffer()) {
        return localeService.getText(TanksLocale.TEXT_FRIENDS_EXIT_FROM_BATTLE_ALERT);
      }
      return localeService.getText(TanksLocale.TEXT_FRIENDS_EXIT_FROM_BATTLE_ALERT) + "\n" + localeService.getText(TanksLocale.TEXT_POSTFIX_OFFER_EXIT_BATTLE);
    }

    private function onQuitBattleDialogButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES)) {
        this.exitFromBattleWithoutNotify();
      }
    }

    private function onQuitBattleToGarageDialogButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleToGarageDialogButtonPressed);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES)) {
        userChangeGameScreenService.exitFromBattleToGarage();
        this.layoutSwitchPredicted();
        ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).exitFromBattleToState(LayoutState.GARAGE);
      } else {
        dispatchEvent(new LobbyLayoutServiceEvent(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,LayoutState.BATTLE));
      }
    }

    public function exitFromBattleWithoutNotify() : void {
      userChangeGameScreenService.exitFromBattleToMatchmaking();
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).exitFromBattle();
    }

    public function exitFromBattleToState(param1:LayoutState) : void {
      switch(param1) {
        case LayoutState.GARAGE:
          userChangeGameScreenService.exitFromBattleToGarage();
          break;
        case LayoutState.CLAN:
          userChangeGameScreenService.exitFromBattleToClan();
          break;
        default:
          userChangeGameScreenService.exitFromBattleToMatchmaking();
      }
      this.layoutSwitchPredicted();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).exitFromBattleToState(param1);
    }

    public function exitFromGame() : void {
      if(!partnersService.isRunningInsidePartnerEnvironment() || Boolean(StartupSettings.isDesktop)) {
        showExitFromGameAlert();
      }
    }

    public function getServiceGameObject() : IGameObject {
      return this.serviceGameObject;
    }

    public function setServiceGameObject(param1:IGameObject) : void {
      this.serviceGameObject = param1;
    }

    private function checkObject() : void {
      if(this.serviceGameObject == null) {
        throw new Error("Service object isn\'t loaded");
      }
    }

    public function isSwitchInProgress() : Boolean {
      this.checkObject();
      return ILobbyLayoutNotify(this.serviceGameObject.adapt(ILobbyLayoutNotify)).isSwitchInProgress();
    }

    public function getCurrentState() : LayoutState {
      this.checkObject();
      return ILobbyLayoutNotify(this.serviceGameObject.adapt(ILobbyLayoutNotify)).getCurrentState();
    }

    public function inBattle() : Boolean {
      if(this.serviceGameObject == null) {
        return false;
      }
      return ILobbyLayoutNotify(this.serviceGameObject.adapt(ILobbyLayoutNotify)).inBattle();
    }

    private function layoutSwitchPredicted() : void {
      this.checkObject();
      ILobbyLayoutNotify(this.serviceGameObject.adapt(ILobbyLayoutNotify)).layoutSwitchPredicted();
    }

    public function isWindowOpenOverBattle() : Boolean {
      return this.inBattle() && (this.getCurrentState() != LayoutState.BATTLE || Boolean(dialogWindowsDispatcherService.isOpen()));
    }

    public function closePopupOverBattle() : void {
      if(!this.isSwitchInProgress() && this.isOpenPopupOverBattle()) {
        this.returnToBattle();
      }
    }

    private function isOpenPopupOverBattle() : Boolean {
      return this.inBattle() && this.getCurrentState() != LayoutState.BATTLE;
    }

    public function returnToBattle() : void {
      userChangeGameScreenService.switchGarage();
      ILobbyLayout(this.serviceGameObject.adapt(ILobbyLayout)).returnToBattle();
    }

    public function setBattleReady(param1:Boolean) : void {
      this.battleReady = param1;
    }

    public function isBattleReady() : Boolean {
      return this.battleReady;
    }
  }
}
