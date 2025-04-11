package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.notificationpausefinish.NotificationEndsPauseSupport;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.battlefield.event.BattleRenameEvent;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.chat.IBattleChat;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.BattleStatistics;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.fps.FPSText;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.BattleMessages;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.tanks.models.battle.gui.statistics.DefaultLayout;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battlemessages.BattlefieldMessages;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.types.Long;
  import alternativa.utils.removeDisplayObject;
  import flash.display.DisplayObjectContainer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.IStatisticsModelBase;
  import projects.tanks.client.battleservice.model.statistics.StatisticsModelBase;
  import projects.tanks.client.battleservice.model.statistics.UserReward;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;

  [ModelInfo]
  public class StatisticsModel extends StatisticsModelBase implements IStatisticsModelBase, IStatisticsModel, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattlefieldGUI, LogicUnit {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    [Inject]
    public static var battleFormatUtil:BattleFormatUtil;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var playerJoinedMessage:String;
    private var playerLeftMessage:String;
    private var fpsIndicator:FPSText;
    private var battleMessages:BattleMessages;
    private var battlefieldMessages:BattlefieldMessages;
    private var battleStatistics:BattleStatistics;
    private var defaultLayout:DefaultLayout;

    public function StatisticsModel() {
      super();
      this.fpsIndicator = new FPSText();
      WinkManager.init(500);
    }

    public function runLogic(param1:int, param2:int) : void {
      this.battlefieldMessages.update(param2);
    }

    public function getBattleName() : String {
      if(Boolean(getInitParam().battleName)) {
        return getInitParam().battleName;
      }
      return this.getDefaultBattleName();
    }

    private function getDefaultBattleName() : String {
      var local1:String = !!getInitParam().matchBattle ? BattleInfoUtils.buildBattleName(getInitParam().mapName,getInitParam().modeName) : getInitParam().mapName;
      var local2:String = getInitParam().equipmentConstraintsMode;
      var local3:Boolean = Boolean(getInitParam().parkourMode);
      if(battleFormatUtil.isFormatBattle(local2,local3)) {
        local1 = local1 + " " + battleFormatUtil.getShortFormatName(local2,local3);
      }
      return local1;
    }

    public function userConnect(param1:ShortUserInfo) : void {
      this.battleMessages.addUserActionMessage(param1,UserAction.PLAYER_JOIN_THE_BATTLE);
    }

    public function userDisconnect(param1:ShortUserInfo) : void {
      this.battleMessages.addUserActionMessage(param1,UserAction.PLAYER_LEAVE_THE_BATTLE);
    }

    public function updateUserKills(param1:Long, param2:int) : void {
      this.battleStatistics.updateUserKills(param1,param2);
    }

    public function changeTeamScore(param1:BattleTeam, param2:int) : void {
      this.battleStatistics.setTeamScore(param1,param2);
    }

    public function logUserAction(param1:Long, param2:UserAction, param3:Long) : void {
      var local4:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
      var local5:ShortUserInfo = local4.getShortUserInfo(param1);
      var local6:ShortUserInfo = param3 == null ? null : local4.getShortUserInfo(param3);
      this.battleMessages.addTwoUsersActionMessage(local5,param2,local6);
    }

    public function logKillAction(param1:Long, param2:Long, param3:DamageType) : void {
      var local4:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
      var local5:ShortUserInfo = local4.getShortUserInfo(param1);
      var local6:ShortUserInfo = local4.getShortUserInfo(param2);
      this.battleMessages.addKillMessage(local5,local6,param3);
    }

    public function setIndicatorState(param1:BattleTeam, param2:int) : void {
      this.battleStatistics.setIndicatorState(param1,param2);
    }

    public function setBothIndicatorsState(param1:int, param2:int) : void {
      this.battleStatistics.setBothIndicatorsState(param1,param2);
    }

    public function showBattleMessage(param1:uint, param2:String) : void {
      this.battlefieldMessages.addMessage(param1,param2);
    }

    public function showPointBattleLogMessage(param1:String, param2:UserAction) : void {
      this.battleMessages.addPointActionMessage(param1,param2);
    }

    public function showUserBattleLogMessage(param1:Long, param2:UserAction) : void {
      var local3:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
      var local4:ShortUserInfo = local3.getShortUserInfo(param1);
      if(Boolean(local4)) {
        this.battleMessages.addUserActionMessage(local4,param2);
      }
    }

    public function showBattleLogMessage(param1:UserAction) : void {
      this.battleMessages.addSimpleActionMessage(param1);
    }

    public function addWidget(param1:Widget) : void {
      this.defaultLayout.addWidget(param1);
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      battleInfoService.running = getInitParam().running;
      this.playerJoinedMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_JOINED);
      this.playerLeftMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_LEFT);
      var local1:BattleUserInfoServiceImpl = new BattleUserInfoServiceImpl(object);
      putData(BattleUserInfoServiceImpl,local1);
      putData(PauseIndicatorSupport,new PauseIndicatorSupport());
      putData(NotificationEndsPauseSupport,new NotificationEndsPauseSupport());
      putData(TankKillLogger,new TankKillLogger(object));
      putData(FpsIndicatorToggleSupport,new FpsIndicatorToggleSupport(this.fpsIndicator));
      var local2:DisplayObjectContainer = battleGUIService.getGuiContainer();
      var local3:BattleType = BattleModel(object.adapt(BattleModel)).getBattleType();
      var local4:Boolean = Boolean(getInitParam().valuableRound);
      this.battleStatistics = new BattleStatistics(userPropertiesService.userId,getInitParam(),local3,local4);
      local2.addChild(this.battleStatistics);
      this.defaultLayout = new DefaultLayout();
      this.defaultLayout.addWidget2(this.battleStatistics);
      this.defaultLayout.init();
      this.battlefieldMessages = new BattlefieldMessages();
      local2.addChild(this.battlefieldMessages);
      putData(BattlefieldMessagesAligner,new BattlefieldMessagesAligner(this.battlefieldMessages));
      this.battleMessages = new BattleMessages();
      local2.addChild(this.battleMessages);
      if(settingsService.showFPS) {
        local2.addChild(this.fpsIndicator);
      }
      if(getInitParam().spectator) {
        this.createSpectatorScreenLayouts();
      } else {
        putData(ControlsMiniHelpSupport,new ControlsMiniHelpSupport());
        putData(ControlsHelpSupport,new ControlsHelpSupport());
      }
    }

    private function battleHasTimeLimit() : Boolean {
      return getInitParam().limits.timeLimitInSec != 0;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:Boolean = false;
      this.markSuspectedUsers(getInitParam().suspiciousUserIds);
      battleService.getBattleRunner().addLogicUnit(this);
      if(this.battleHasTimeLimit()) {
        local1 = Boolean(getInitParam().spectator);
        if(!local1 || local1 && this.battleUserInfoService().getUsersCount() > 0) {
          this.battleStatistics.startCountdownTimeLimit(getInitParam().timeLeft);
        }
      }
    }

    private function createSpectatorScreenLayouts() : void {
      var local1:IBattleChat = IBattleChat(object.adapt(IBattleChat));
      putData(SpectatorScreenLayouts,new SpectatorScreenLayouts(local1.getChat(),this.battleMessages,this.battlefieldMessages,this.battleStatistics,this.fpsIndicator));
    }

    private function markSuspectedUsers(param1:Vector.<Long>) : void {
      var local2:Long = null;
      for each(local2 in param1) {
        this.setUserSuspiciousness(local2,true);
      }
    }

    private function setUserSuspiciousness(param1:Long, param2:Boolean) : void {
      var local3:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
      local3.suspiciousnessChanged(param1,param2);
      var local4:BattleUserInfoServiceImpl = this.battleUserInfoService();
      local4.dispatchSuspiciousnessChange(param1,param2);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      removeDisplayObject(this.battleStatistics);
      removeDisplayObject(this.battleMessages);
      removeDisplayObject(this.fpsIndicator);
      this.battleStatistics = null;
      battleService.getBattleRunner().removeLogicUnit(this);
      this.battleMessages = null;
      this.battlefieldMessages.removeFromParent();
      this.battlefieldMessages = null;
      this.defaultLayout.destroy();
      this.defaultLayout = null;
    }

    [Obfuscation(rename="false")]
    public function fundChange(param1:int) : void {
      this.battleStatistics.updateFund(param1);
    }

    [Obfuscation(rename="false")]
    public function roundStart(param1:int, param2:Boolean) : void {
      battleInfoService.running = true;
      this.battleStatistics.initOnRoundStart(param2);
      if(this.battleHasTimeLimit()) {
        this.battleStatistics.startCountdownTimeLimit(param1);
      }
      var local3:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
      local3.roundStart();
    }

    [Obfuscation(rename="false")]
    public function roundStop() : void {
      battleInfoService.running = false;
      if(this.battleHasTimeLimit()) {
        this.battleStatistics.stopCountdownTimeLimit();
      }
      this.battleStatistics.resetFields();
      var local1:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
      local1.roundStop();
    }

    [Obfuscation(rename="false")]
    public function roundFinish(param1:Boolean, param2:Vector.<UserReward>, param3:int) : void {
      battleInfoService.running = false;
      var local4:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
      local4.roundFinish(getInitParam().matchBattle,param1,param3,param2);
      this.battleStatistics.finish();
    }

    [Obfuscation(rename="false")]
    public function statusProbablyCheaterChanged(param1:Long, param2:Boolean) : void {
      this.setUserSuspiciousness(param1,param2);
    }

    [Obfuscation(rename="false")]
    public function onRankChanged(param1:Long, param2:int, param3:Boolean) : void {
      var local5:BattleUserInfoServiceImpl = null;
      var local4:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
      local4.rankChanged(param1,param2);
      if(Boolean(localTankInfoService.isLocalTankLoaded()) && param1 == localTankInfoService.getLocalTankObject().id) {
        ControlsMiniHelpSupport(getData(ControlsMiniHelpSupport)).close();
      }
      if(!param3) {
        local5 = this.battleUserInfoService();
        local5.dispatchRankChange(param1,param2);
      }
    }

    public function turnOnTimerToRestoreBalance(param1:int) : void {
      this.battleStatistics.turnOnTimerToRestoreBalance(param1);
    }

    public function turnOffTimerToRestoreBalance() : void {
      this.battleStatistics.turnOffTimerToRestoreBalance();
    }

    private function battleUserInfoService() : BattleUserInfoServiceImpl {
      return BattleUserInfoServiceImpl(getData(BattleUserInfoServiceImpl));
    }

    public function notifyAboutTraining(param1:int) : void {
      this.battlefieldMessages.addMessageWithDuration(MessageColor.ORANGE,localeService.getText(TanksLocale.TEXT_TOURNAMENT_BATTLE_TRAINING_LABEL),param1 * 1000);
    }

    public function notifyAboutBattle(param1:int) : void {
      this.battlefieldMessages.addMessageWithDuration(MessageColor.RED,localeService.getText(TanksLocale.TEXT_TOURNAMENT_BATTLE_STARTING_LABEL),param1 * 1000);
    }

    public function getTimeLeftInSec() : int {
      return getInitParam().timeLeft;
    }

    public function setBattleName(param1:String) : void {
      battleEventDispatcher.dispatchEvent(new BattleRenameEvent(param1));
    }

    public function resetBattleName() : void {
      battleEventDispatcher.dispatchEvent(new BattleRenameEvent(this.getDefaultBattleName()));
    }
  }
}
