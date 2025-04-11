package alternativa.tanks.controllers.battleinfo {
  import alternativa.tanks.view.battleinfo.AbstractBattleInfoView;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.tanks.view.battleinfo.BattleInfoViewEvent;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;

  public class AbstractBattleInfoController extends EventDispatcher implements IBattleInfoController {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var userProBattleService:IUserProBattleService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private static const TIME_LEFT_TIMER_DELAY:int = 500;

    protected var view:AbstractBattleInfoView;

    private var countDownTimer:Timer;
    private var endTime:int;

    protected var availableByRank:Boolean;
    protected var initParams:BattleInfoBaseParams;
    protected var maxPeopleCount:int;
    protected var timeLimitInSec:int;

    public function AbstractBattleInfoController() {
      super();
      this.countDownTimer = new Timer(TIME_LEFT_TIMER_DELAY);
    }

    public function showForm(param1:BattleInfoBaseParams) : void {
      this.initParams = param1;
      this.maxPeopleCount = param1.createParams.maxPeopleCount;
      this.timeLimitInSec = param1.createParams.limits.timeLimitInSec;
      this.setEvents();
      this.view.update(param1);
      this.view.battleInfoParamsView.update(param1);
      this.updateUserLists();
      this.updateControlPanel();
      this.updateSettingsTimeLimit(param1.roundStarted,param1.endTime);
      this.updateProBattleStatus();
      this.updateAvailableByRank();
      this.updateAvailableEnterInBattle();
      this.view.updateInBattleState();
      this.view.show();
    }

    protected function updateControlPanel() : void {
    }

    private function updateProBattleStatus() : void {
      if(this.initParams.createParams.proBattle && !userProBattleService.hasAbonement()) {
        this.view.showProBattlePassAlert();
      } else {
        this.view.hideNoSupplies();
      }
    }

    private function setEvents() : void {
      this.view.addEventListener(BattleInfoViewEvent.ENTER_BATTLE,this.onEnterBattle);
      this.view.addEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      this.view.addEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,this.onBuyProAbonement);
      userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onLobbyLayoutStateChange);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onLobbyLayoutStateChange);
      clanUserInfoService.addEventListener(ClanUserInfoEvent.UPDATE_GIVE_BONUSES_CLAN,this.onUpdateGiveClanBonuses);
    }

    private function onBuyProAbonement(param1:BattleInfoViewEvent) : void {
      dispatchEvent(param1.clone());
    }

    private function onUpdateRank(param1:UserPropertiesServiceEvent) : void {
      this.updateAvailableByRank();
      this.updateAvailableEnterInBattle();
    }

    private function updateSettingsTimeLimit(param1:Boolean, param2:int) : void {
      this.stopTimerCountDown();
      if(param2 > getTimer()) {
        this.endTime = param2;
        if(param1) {
          this.restartTimerCountDown();
        } else {
          this.updateTimeAndPercentLeft(0);
        }
      } else {
        this.updateTimeAndPercentLeft(0);
      }
    }

    protected function updateUserLists() : void {
    }

    private function updateAvailableByRank() : void {
      var local1:int = int(userPropertiesService.rank);
      this.availableByRank = local1 >= this.initParams.createParams.rankRange.min && local1 <= this.initParams.createParams.rankRange.max;
    }

    protected function updateAvailableEnterInBattle() : void {
    }

    public function hideForm() : void {
      this.removeEvents();
      this.stopTimerCountDown();
      this.view.hide();
    }

    public function addFormToStage() : void {
      this.view.show();
    }

    public function removeFormFromStage() : void {
      this.view.hide();
    }

    private function removeEvents() : void {
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onLobbyLayoutStateChange);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onLobbyLayoutStateChange);
      this.view.removeEventListener(BattleInfoViewEvent.ENTER_BATTLE,this.onEnterBattle);
      this.view.removeEventListener(BattleInfoViewEvent.ENTER_SPECTATOR,this.onEnterSpectator);
      this.view.removeEventListener(BattleInfoViewEvent.BUY_PRO_ABONEMENT,this.onBuyProAbonement);
      userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
      clanUserInfoService.removeEventListener(ClanUserInfoEvent.UPDATE_GIVE_BONUSES_CLAN,this.onUpdateGiveClanBonuses);
    }

    public function destroy() : void {
      this.hideForm();
      this.removeEvents();
      this.stopTimerCountDown();
      this.view.destroy();
      this.view = null;
      this.countDownTimer = null;
      this.initParams = null;
    }

    public function removeUser(param1:Long) : void {
    }

    public function updateUserScore(param1:Long, param2:int) : void {
    }

    public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
    }

    public function roundStart(param1:int) : void {
      this.updateSettingsTimeLimit(true,getTimer() + param1 * 1000);
      this.updateUserLists();
    }

    public function roundFinish() : void {
      this.stopTimerCountDown();
      this.updateTimeAndPercentLeft(0);
    }

    public function battleStop() : void {
      this.stopTimerCountDown();
      this.updateTimeAndPercentLeft(this.timeLimitInSec);
    }

    private function startCountDown() : void {
      this.countDownTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
      this.countDownTimer.start();
      this.onTimer(null);
    }

    private function stopTimerCountDown() : void {
      this.countDownTimer.stop();
      this.countDownTimer.removeEventListener(TimerEvent.TIMER,this.onTimer);
    }

    private function restartTimerCountDown() : void {
      this.stopTimerCountDown();
      this.startCountDown();
    }

    private function onTimer(param1:TimerEvent) : void {
      var local2:int = getTimer();
      if(local2 > this.endTime) {
        this.countDownTimer.removeEventListener(TimerEvent.TIMER,this.onTimer);
        this.countDownTimer.stop();
      } else {
        this.updateTimeAndPercentLeft((this.endTime - local2) / 1000);
      }
    }

    private function onEnterBattle(param1:BattleInfoViewEvent) : void {
      userChangeGameScreenService.enterBattle();
      dispatchEvent(param1.clone());
    }

    private function onEnterSpectator(param1:BattleInfoViewEvent) : void {
      userChangeGameScreenService.enterBattle();
      dispatchEvent(param1.clone());
    }

    private function onLobbyLayoutStateChange(param1:LobbyLayoutServiceEvent = null) : void {
      if(lobbyLayoutService.isSwitchInProgress()) {
        this.view.lock();
      } else {
        this.view.unlock();
      }
      this.view.updateInBattleState();
    }

    private function onUpdateGiveClanBonuses(param1:ClanUserInfoEvent) : void {
      this.view.updateInBattleState();
    }

    private function updateTimeAndPercentLeft(param1:int) : void {
      this.view.battleInfoParamsView.setTimeAndPercentLeft(param1);
    }

    public function getSelectedBattle() : IGameObject {
      return this.initParams.battle;
    }

    public function updateBattleName() : void {
      this.view.updateBattleName();
    }
  }
}
