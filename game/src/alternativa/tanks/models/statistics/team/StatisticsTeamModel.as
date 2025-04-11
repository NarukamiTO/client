package alternativa.tanks.models.statistics.team {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.gui.battle.BattleFinishTeamNotification;
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
  import forms.ChangeTeamAlert;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserReward;
  import projects.tanks.client.battleservice.model.statistics.UserStat;
  import projects.tanks.client.battleservice.model.statistics.team.IStatisticsTeamModelBase;
  import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamModelBase;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class StatisticsTeamModel extends StatisticsTeamModelBase implements IStatisticsTeamModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, IClientUserInfo, IStatisticRound, GameActionListener {
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
    public static var challengeInfoService:ChallengeInfoService;

    [Inject]
    public static var battlePremiumService:BattleUserPremiumService;

    private var battleEventSupport:BattleEventSupport;
    private var statisticsTable:StatisticsTable;
    private var redClientUsersStat:Vector.<ClientUserStat>;
    private var blueClientUsersStat:Vector.<ClientUserStat>;
    private var clientUsersInfo:Dictionary;
    private var localUserTeam:BattleTeam;
    private var localUserTankTeamType:BattleTeam;
    private var scoreRed:int;
    private var scoreBlue:int;
    private var usersCount:int;

    public function StatisticsTeamModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      this.battleEventSupport.addEventHandler(BattleRenameEvent,this.onBattleRename);
    }

    private static function showChangeTeamAlert(param1:BattleTeam) : void {
      var local2:ChangeTeamAlert = new ChangeTeamAlert(3,param1 == BattleTeam.RED ? int(ChangeTeamAlert.RED) : int(ChangeTeamAlert.BLUE));
      local2.x = display.stage.stageWidth - local2.width >> 1;
      local2.y = display.stage.stageHeight - local2.height >> 1;
      battleGUIService.getGuiContainer().addChild(local2);
    }

    private static function createUsersInfo(param1:Vector.<UserInfo>, param2:Vector.<UserInfo>) : Dictionary {
      var local4:UserInfo = null;
      var local5:UserInfo = null;
      var local6:ClientUserInfo = null;
      var local3:Dictionary = new Dictionary();
      for each(local4 in param1) {
        local3[local4.user] = StatisticsVectorUtils.createClientUserInfo(local4,BattleTeam.RED);
      }
      for each(local5 in param2) {
        local3[local5.user] = StatisticsVectorUtils.createClientUserInfo(local5,BattleTeam.BLUE);
      }
      for each(local6 in local3) {
        local6.loaded = true;
      }
      return local3;
    }

    private static function updateBattleTeam(param1:Vector.<ClientUserStat>, param2:BattleTeam) : void {
      var local5:ClientUserStat = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(local5 == null) {
          break;
        }
        local5.teamType = param2;
        local4++;
      }
    }

    private function onBattleRename(param1:BattleRenameEvent) : void {
      this.statisticsTable.setBattleName(param1.name);
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank.getUser().id == userPropertiesService.userId) {
        if(param1.tank.teamType != this.localUserTankTeamType) {
          this.localUserTankTeamType = param1.tank.teamType;
          showChangeTeamAlert(this.localUserTankTeamType);
        }
      }
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      var local2:ClientUserStat = this.getUserStat(param1.tank.getUser().id);
      local2.loaded = true;
      this.statisticsTable.updatePlayerTeam(local2);
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.localUserTankTeamType = BattleTeam.NONE;
      var local1:Vector.<UserInfo> = getInitParam().usersInfoRed.slice();
      local1 = local1.concat(getInitParam().usersInfoBlue);
      battlePremiumService.setUsersPremium(local1);
      this.clientUsersInfo = createUsersInfo(getInitParam().usersInfoRed,getInitParam().usersInfoBlue);
      this.usersCount = getInitParam().usersInfoRed.length + getInitParam().usersInfoBlue.length;
      this.redClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfoRed);
      this.blueClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfoBlue);
      var local2:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      this.statisticsTable = new StatisticsTable(local2.getBattleName(),true);
      this.statisticsTable.addEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
      this.statisticsTable.addEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
      battleGUIService.getTabContainer().addChild(this.statisticsTable);
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.changeTeamScore(BattleTeam.RED,getInitParam().redScore);
      this.changeTeamScore(BattleTeam.BLUE,getInitParam().blueScore);
      this.updateLocalUserTeam();
      this.battleEventSupport.activateHandlers();
      battleInputService.addGameActionListener(this);
    }

    private function updateLocalUserTeam() : void {
      var local1:ClientUserStat = this.getUserStat(userPropertiesService.userId);
      if(local1 != null) {
        this.localUserTeam = local1.teamType;
      }
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
        this.statisticsTable.showTeam(false,userPropertiesService.userId,this.redClientUsersStat,this.blueClientUsersStat,false,0,this.localUserTeam,false);
      }
    }

    private function hideScores() : void {
      if(battleInfoService.running) {
        this.statisticsTable.hide();
      }
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
      this.redClientUsersStat = null;
      this.blueClientUsersStat = null;
      this.clientUsersInfo = null;
      this.localUserTankTeamType = null;
      this.usersCount = 0;
      battlePremiumService.removeUsersPremium();
    }

    [Obfuscation(rename="false")]
    public function changeTeamScore(param1:BattleTeam, param2:int) : void {
      if(param1 == BattleTeam.RED) {
        this.scoreRed = param2;
      }
      if(param1 == BattleTeam.BLUE) {
        this.scoreBlue = param2;
      }
      var local3:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      local3.changeTeamScore(param1,param2);
    }

    [Obfuscation(rename="false")]
    public function userConnect(param1:Long, param2:Vector.<UserInfo>, param3:BattleTeam) : void {
      var local4:UserInfo = StatisticsVectorUtils.getUserInfo(param1,param2);
      this.clientUsersInfo[param1] = StatisticsVectorUtils.createClientUserInfo(local4,param3);
      ++this.usersCount;
      battlePremiumService.setUsersPremium(param2);
      if(param3 == BattleTeam.RED) {
        this.redClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
        if(battleInfoService.running) {
          this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,param3);
        }
      }
      if(param3 == BattleTeam.BLUE) {
        this.blueClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
        if(battleInfoService.running) {
          this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,param3);
        }
      }
    }

    [Obfuscation(rename="false")]
    public function userDisconnect(param1:Long) : void {
      var local2:ClientUserInfo = this.clientUsersInfo[param1];
      var local3:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      local3.userDisconnect(local2.getShortUserInfo());
      if(battleInfoService.running) {
        this.statisticsTable.removePlayer(param1,local2.teamType);
      }
      if(local2.teamType == BattleTeam.RED) {
        this.redClientUsersStat = StatisticsVectorUtils.deleteUserStat(this.redClientUsersStat,param1);
      }
      if(local2.teamType == BattleTeam.BLUE) {
        this.blueClientUsersStat = StatisticsVectorUtils.deleteUserStat(this.blueClientUsersStat,param1);
      }
      delete this.clientUsersInfo[param1];
      --this.usersCount;
      battlePremiumService.resetUserPremium(param1);
    }

    [Obfuscation(rename="false")]
    public function changeUserStat(param1:UserStat, param2:BattleTeam) : void {
      var local3:ClientUserStat = null;
      if(param2 == BattleTeam.RED) {
        local3 = StatisticsVectorUtils.changeUserStat(this.redClientUsersStat,param1);
      }
      if(param2 == BattleTeam.BLUE) {
        local3 = StatisticsVectorUtils.changeUserStat(this.blueClientUsersStat,param1);
      }
      var local4:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
      local4.updateUserKills(param1.user,param1.kills);
      this.statisticsTable.updatePlayerTeam(local3);
    }

    [Obfuscation(rename="false")]
    public function refreshUsersStat(param1:Vector.<UserStat>, param2:BattleTeam) : void {
      if(param2 == BattleTeam.RED) {
        this.redClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
        this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,param2);
      }
      if(param2 == BattleTeam.BLUE) {
        this.blueClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
        this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,param2);
      }
    }

    [Obfuscation(rename="false")]
    public function swapTeam(param1:Vector.<UserStat>, param2:Vector.<UserStat>) : void {
      this.redClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
      this.blueClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param2);
      updateBattleTeam(this.redClientUsersStat,BattleTeam.RED);
      updateBattleTeam(this.blueClientUsersStat,BattleTeam.BLUE);
      this.updateLocalUserTeam();
      this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,BattleTeam.RED);
      this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,BattleTeam.BLUE);
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

    private function getUserStat(param1:Long) : ClientUserStat {
      var local2:ClientUserStat = StatisticsVectorUtils.getClientUserStat(this.redClientUsersStat,param1);
      if(local2 == null) {
        local2 = StatisticsVectorUtils.getClientUserStat(this.blueClientUsersStat,param1);
      }
      return local2;
    }

    public function suspiciousnessChanged(param1:Long, param2:Boolean) : void {
      var local3:ClientUserStat = this.getUserStat(param1);
      if(local3 != null) {
        local3.suspicious = param2;
        this.statisticsTable.updatePlayerTeam(local3);
      }
    }

    public function rankChanged(param1:Long, param2:int) : void {
      var local3:ClientUserStat = this.getUserStat(param1);
      local3.rank = param2;
      this.statisticsTable.updatePlayerTeam(local3);
    }

    public function roundStart() : void {
      this.statisticsTable.hide();
      this.changeTeamScore(BattleTeam.RED,0);
      this.changeTeamScore(BattleTeam.BLUE,0);
    }

    public function roundStop() : void {
      this.statisticsTable.hide();
    }

    public function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void {
      var local5:Boolean = false;
      var local6:UserReward = null;
      var local7:int = 0;
      this.statisticsTable.hide();
      StatisticsVectorUtils.updateReward(this.redClientUsersStat,param4);
      StatisticsVectorUtils.updateReward(this.blueClientUsersStat,param4);
      if(param2) {
        local5 = param1 && Boolean(challengeInfoService.isInTime());
        this.statisticsTable.showTeam(param1,userPropertiesService.userId,this.redClientUsersStat,this.blueClientUsersStat,true,!!serverHaltService.isServerHalt ? -1 : param3,this.localUserTeam,local5);
      }
      if(param2 && Boolean(lobbyLayoutService.isWindowOpenOverBattle()) && !battleInfoService.isSpectatorMode()) {
        local6 = StatisticsVectorUtils.getRewardById(userPropertiesService.userId,param4);
        local7 = local6.reward + local6.newbiesAbonementBonusReward + local6.premiumBonusReward;
        notificationService.addNotification(new BattleFinishTeamNotification(this.isYourTeamVictory(),this.isYourTeamDefeat(),this.getLocalUserPlace(),this.getYourTeamPlaces(),local7,local6.starsReward,local5));
      }
    }

    private function isYourTeamVictory() : Boolean {
      if(this.localUserTeam == BattleTeam.RED) {
        return this.scoreRed > this.scoreBlue;
      }
      if(this.localUserTeam == BattleTeam.BLUE) {
        return this.scoreBlue > this.scoreRed;
      }
      return false;
    }

    private function isYourTeamDefeat() : Boolean {
      if(this.localUserTeam == BattleTeam.RED) {
        return this.scoreBlue > this.scoreRed;
      }
      if(this.localUserTeam == BattleTeam.BLUE) {
        return this.scoreRed > this.scoreBlue;
      }
      return false;
    }

    private function getYourTeamPlaces() : int {
      if(this.localUserTeam == BattleTeam.RED) {
        return this.redClientUsersStat.length;
      }
      if(this.localUserTeam == BattleTeam.BLUE) {
        return this.blueClientUsersStat.length;
      }
      return 0;
    }

    private function getLocalUserPlace() : int {
      var local1:int = 0;
      if(this.localUserTeam == BattleTeam.RED) {
        local1 = StatisticsVectorUtils.getUserPosition(this.redClientUsersStat,userPropertiesService.userId);
      } else if(this.localUserTeam == BattleTeam.BLUE) {
        local1 = StatisticsVectorUtils.getUserPosition(this.blueClientUsersStat,userPropertiesService.userId);
      }
      return local1 + 1;
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

    public function getUsersCount() : int {
      return this.usersCount;
    }
  }
}
