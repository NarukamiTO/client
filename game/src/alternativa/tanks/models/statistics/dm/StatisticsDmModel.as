package alternativa.tanks.models.statistics.dm {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.gui.battle.BattleFinishDmNotification;
  import alternativa.tanks.models.battle.battlefield.event.BattleRenameEvent;
  import alternativa.tanks.models.battle.battlefield.event.ContinueBattleEvent;
  import alternativa.tanks.models.battle.gui.gui.statistics.table.StatisticsTable;
  import alternativa.tanks.models.battle.gui.statistics.ClientUserInfo;
  import alternativa.tanks.models.battle.gui.statistics.ClientUserStat;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battle.gui.statistics.StatisticsVectorUtils;
  import alternativa.tanks.models.continuebattle.ContinueBattle;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.models.statistics.IStatisticRound;
  import alternativa.tanks.models.statistics.IStatisticsModel;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.types.Long;
  import alternativa.utils.removeDisplayObject;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserReward;
  import projects.tanks.client.battleservice.model.statistics.UserStat;
  import projects.tanks.client.battleservice.model.statistics.dm.IStatisticsDMModelBase;
  import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMModelBase;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class StatisticsDmModel extends StatisticsDMModelBase implements IStatisticsDMModelBase, IObjectLoadListener, IClientUserInfo, IStatisticRound, GameActionListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var serverHaltService:IServerHaltService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var notificationService:INotificationService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var reconnectService:ReconnectService;

    [Inject]
    public static var starsEventService:ChallengeInfoService;

    [Inject]
    public static var battlePremiumService:BattleUserPremiumService;

    private var battleEventSupport:BattleEventSupport;
    private var statisticsTable:StatisticsTable;
    private var clientUsersInfo:Dictionary;
    private var clientUsersStat:Vector.<ClientUserStat>;
    private var usersCount:int;

    public function StatisticsDmModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      this.battleEventSupport.addEventHandler(BattleRenameEvent,this.onBattleRename);
    }

    private static function createUsersInfo(param1:Vector.<UserInfo>) : Dictionary {
      var local5:ClientUserInfo = null;
      var local6:UserInfo = null;
      var local7:ClientUserInfo = null;
      var local2:Dictionary = new Dictionary();
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local6 = param1[local4];
        local7 = StatisticsVectorUtils.createClientUserInfo(local6,BattleTeam.NONE);
        local2[local6.user] = local7;
        local4++;
      }
      for each(local5 in local2) {
        local5.loaded = true;
      }
      return local2;
    }

    private function onBattleRename(param1:BattleRenameEvent) : void {
      this.statisticsTable.setBattleName(param1.name);
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      var local2:ClientUserStat = this.getUserStat(param1.tank.getUser().id);
      local2.loaded = true;
      this.statisticsTable.updatePlayerDm(local2);
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:Vector.<UserInfo> = getInitParam().usersInfo;
      battlePremiumService.setUsersPremium(local1);
      this.clientUsersInfo = createUsersInfo(local1);
      this.clientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfo);
      this.usersCount = getInitParam().usersInfo.length;
      var local2:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      this.statisticsTable = new StatisticsTable(local2.getBattleName(),false);
      this.statisticsTable.addEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
      this.statisticsTable.addEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
      battleGUIService.getTabContainer().addChild(this.statisticsTable);
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.battleEventSupport.activateHandlers();
      battleInputService.addGameActionListener(this);
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.SHOW_BATTLE_STATS_TABLE) {
        if(param2) {
          this.showScores();
        } else {
          this.hideScores();
        }
      }
    }

    private function showScores() : void {
      if(battleInfoService.running) {
        this.statisticsTable.showDm(false,false,userPropertiesService.userId,this.clientUsersStat,false,0);
      }
    }

    private function hideScores() : void {
      if(battleInfoService.running) {
        this.statisticsTable.hide();
      }
    }

    private function onExit(param1:ContinueBattleEvent) : void {
      if(!lobbyLayoutService.isSwitchInProgress()) {
        if(!battleInfoService.running) {
          lobbyLayoutService.exitFromBattleWithoutNotify();
        } else {
          lobbyLayoutService.exitFromBattle();
        }
      }
    }

    private function onContinue(param1:ContinueBattleEvent) : void {
      ContinueBattle(object.adapt(ContinueBattle)).continueBattle();
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
      battleInputService.removeGameActionListener(this);
      this.statisticsTable.hide();
      this.statisticsTable.removeEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
      this.statisticsTable.removeEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
      removeDisplayObject(this.statisticsTable);
      this.statisticsTable = null;
      this.clientUsersInfo.length = 0;
      this.clientUsersStat.length = 0;
      this.clientUsersStat = null;
      this.clientUsersInfo = null;
      this.usersCount = 0;
      battlePremiumService.removeUsersPremium();
    }

    [Obfuscation(rename="false")]
    public function objectUnloadedPost() : void {
    }

    [Obfuscation(rename="false")]
    public function changeUserStat(param1:UserStat) : void {
      var local2:ClientUserStat = StatisticsVectorUtils.changeUserStat(this.clientUsersStat,param1);
      this.statisticsTable.updatePlayerDm(local2);
      var local3:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      local3.updateUserKills(local2.userId,local2.kills);
    }

    [Obfuscation(rename="false")]
    public function refreshUsersStat(param1:Vector.<UserStat>) : void {
      this.clientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
      var local2:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local2.updateUserKills(param1[local4].user,param1[local4].kills);
        local4++;
      }
      this.statisticsTable.updatePlayersDm(this.clientUsersStat);
    }

    [Obfuscation(rename="false")]
    public function userConnect(param1:Long, param2:Vector.<UserInfo>) : void {
      var local3:UserInfo = StatisticsVectorUtils.getUserInfo(param1,param2);
      this.clientUsersInfo[param1] = StatisticsVectorUtils.createClientUserInfo(local3,BattleTeam.NONE);
      ++this.usersCount;
      battlePremiumService.setUsersPremium(param2);
      this.clientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
      if(battleInfoService.running) {
        this.statisticsTable.updatePlayersDm(this.clientUsersStat);
      }
    }

    [Obfuscation(rename="false")]
    public function userDisconnect(param1:Long) : void {
      if(battleInfoService.running) {
        this.statisticsTable.removePlayer(param1,BattleTeam.NONE);
      }
      var local2:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      var local3:ClientUserInfo = this.clientUsersInfo[param1];
      local2.userDisconnect(local3.getShortUserInfo());
      delete this.clientUsersInfo[param1];
      --this.usersCount;
      this.clientUsersStat = StatisticsVectorUtils.deleteUserStat(this.clientUsersStat,param1);
      battlePremiumService.resetUserPremium(param1);
    }

    public function getShortUserInfo(param1:Long) : ShortUserInfo {
      var local2:ClientUserInfo = this.clientUsersInfo[param1];
      if(local2 != null) {
        return local2.getShortUserInfo();
      }
      return null;
    }

    public function isLoaded(param1:Long) : Boolean {
      var local2:ClientUserInfo = this.clientUsersInfo[param1];
      return local2 != null && local2.loaded;
    }

    public function suspiciousnessChanged(param1:Long, param2:Boolean) : void {
      var local3:ClientUserStat = this.getUserStat(param1);
      if(local3 != null) {
        local3.suspicious = param2;
        this.statisticsTable.updatePlayerDm(local3);
      }
    }

    public function rankChanged(param1:Long, param2:int) : void {
      var local3:ClientUserStat = this.getUserStat(param1);
      local3.rank = param2;
      this.statisticsTable.updatePlayerDm(local3);
    }

    public function roundStart() : void {
      this.statisticsTable.hide();
    }

    public function roundStop() : void {
      this.statisticsTable.hide();
    }

    public function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void {
      var local5:int = 0;
      var local6:Boolean = false;
      var local7:UserReward = null;
      var local8:int = 0;
      this.statisticsTable.hide();
      StatisticsVectorUtils.updateReward(this.clientUsersStat,param4);
      if(param2) {
        local5 = !!serverHaltService.isServerHalt ? -1 : param3;
        local6 = param1 && Boolean(starsEventService.isInTime());
        this.statisticsTable.showDm(param1,local6,userPropertiesService.userId,this.clientUsersStat,true,local5);
        if(Boolean(lobbyLayoutService.isWindowOpenOverBattle()) && !battleInfoService.isSpectatorMode()) {
          local7 = StatisticsVectorUtils.getRewardById(userPropertiesService.userId,param4);
          local8 = local7.reward + local7.premiumBonusReward + local7.newbiesAbonementBonusReward;
          notificationService.addNotification(new BattleFinishDmNotification(this.getLocalUserPlace(),this.clientUsersStat.length,local8,local7.starsReward,local6));
        }
      }
    }

    private function getLocalUserPlace() : int {
      return StatisticsVectorUtils.getUserPosition(this.clientUsersStat,userPropertiesService.userId) + 1;
    }

    private function getUserStat(param1:Long) : ClientUserStat {
      return StatisticsVectorUtils.getClientUserStat(this.clientUsersStat,param1);
    }

    public function getUsersCount() : int {
      return this.usersCount;
    }
  }
}
