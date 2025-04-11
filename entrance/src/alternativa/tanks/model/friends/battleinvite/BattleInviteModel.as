package alternativa.tanks.model.friends.battleinvite {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.battleinvite.BattleInviteNotification;
  import alternativa.tanks.gui.friends.battleinvite.ResponseBattleInviteNotification;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.battleinvite.BattleInviteMessage;
  import projects.tanks.client.panel.model.battleinvite.BattleInviteModelBase;
  import projects.tanks.client.panel.model.battleinvite.IBattleInviteModelBase;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkActivatorServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkAliveEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendStateChangeEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class BattleInviteModel extends BattleInviteModelBase implements IBattleInviteModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleInviteService:IBattleInviteService;

    [Inject]
    public static var notificationService:INotificationService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleLinkActivatorService:IBattleLinkActivatorService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var notificationSoundService:INotificationSoundService;

    [Inject]
    public static var serverNameService:ServerNumberToLocaleServerService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var reconnectService:ReconnectService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private var inviteList:Dictionary;
    private var inviteUserId:Long;
    private var userId:Long;
    private var battleData:BattleInfoData;

    public function BattleInviteModel() {
      super();
    }

    private static function addNotificationAlreadyInvite(param1:Long) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_IS_CONSIDERING_YOUR_INVITE_LABEL);
      if(!notificationService.hasNotification(param1,local2)) {
        notificationService.addNotification(new ResponseBattleInviteNotification(param1,local2));
      }
    }

    private static function createInviteBattleMessage(param1:BattleInviteMessage) : String {
      var local2:String = localeService.getText(TanksLocale.TEXT_INVITES_YOU_TO_A_BATTLE_LABEL) + "\n";
      if(isAvailableRank(param1.battleData.range)) {
        if(param1.availableSlot) {
          local2 += "\n" + localeService.getText(TanksLocale.TEXT_THERE_ARE_PLACES_AVAILABLE_LABEL);
        } else {
          local2 += "\n" + setGreyColor(localeService.getText(TanksLocale.TEXT_NO_PLACES_AVAILABLE_LABEL));
        }
      } else {
        local2 += "\n" + setGreyColor(localeService.getText(TanksLocale.TEXT_BATTLE_IS_UNAVAILABLE_AT_YOUR_RANK_LABEL));
      }
      return local2;
    }

    private static function isAvailableRank(param1:Range) : Boolean {
      return param1.min <= userPropertiesService.rank && userPropertiesService.rank <= param1.max;
    }

    private static function createMapAndModeString(param1:BattleInfoData) : String {
      return BattleInfoUtils.buildBattleName(param1.mapName,param1.mode.name);
    }

    private static function setGreyColor(param1:String) : String {
      return "<font color=\'#" + "b1b1b1" + "\'>" + param1 + "</font>";
    }

    private static function addNotificationBattleNotFound(param1:Long) : void {
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_BATTLE_CANNOT_BE_FOUND_LABEL)));
    }

    public function objectLoaded() : void {
      this.inviteList = new Dictionary();
      var local1:SoundResource = getInitParam().soundNotification;
      if(local1 != null && local1.isLoaded) {
        notificationSoundService.notificationSound = getInitParam().soundNotification.sound;
      }
      battleInviteService.addEventListener(BattleInviteServiceEvent.INVITE,getFunctionWrapper(this.onBattleInvite));
      battleInviteService.addEventListener(BattleInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
      battleInviteService.addEventListener(BattleInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
      battleLinkActivatorService.addEventListener(BattleLinkAliveEvent.ALIVE,getFunctionWrapper(this.onAlive));
      battleLinkActivatorService.addEventListener(BattleLinkAliveEvent.DEAD,getFunctionWrapper(this.onDead));
      friendInfoService.addEventListener(FriendStateChangeEvent.CHANGE,getFunctionWrapper(this.onChangeFriendState));
    }

    private function onBattleInvite(param1:BattleInviteServiceEvent) : void {
      var local2:IUserInfoLabelUpdater = null;
      this.inviteUserId = param1.userId;
      if(this.inviteUserId in this.inviteList) {
        addNotificationAlreadyInvite(this.inviteUserId);
      } else if(battleInfoService.hasCurrentSelectionBattleId()) {
        local2 = userInfoService.getOrCreateUpdater(this.inviteUserId);
        if(battleInfoService.availableRank(local2.rank)) {
          this.sendInviteToServer();
        } else {
          alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_INVITE_TO_BATTLE_IS_UNAVAILABLE_RANK),Vector.<String>([localeService.getText(AlertAnswer.YES),localeService.getText(AlertAnswer.NO)]));
          alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onBattleInviteAlertClick));
        }
      } else {
        addNotificationBattleNotFound(this.inviteUserId);
      }
    }

    private function sendInviteToServer() : void {
      this.inviteList[this.inviteUserId] = true;
      var local1:Long = this.getBattleId();
      server.invite(this.inviteUserId,local1);
      this.inviteUserId = null;
    }

    private function getBattleId() : Long {
      if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE) {
        return battleInfoService.currentBattleId;
      }
      return battleInfoService.currentSelectionBattleId;
    }

    private function onBattleInviteAlertClick(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onBattleInviteAlertClick));
      if(param1.typeButton == localeService.getText(AlertAnswer.YES)) {
        this.sendInviteToServer();
      }
    }

    private function onAccept(param1:BattleInviteServiceEvent) : void {
      this.userId = param1.userId;
      this.battleData = param1.battleData;
      battleLinkActivatorService.isAlive(this.battleData.battleId);
    }

    private function onAlive(param1:BattleLinkAliveEvent) : void {
      if(this.battleData.battleId != param1.battleId) {
        return;
      }
      if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.isSpectatorMode()) {
        battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE,getFunctionWrapper(this.onConfirmedNavigate));
        battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE,getFunctionWrapper(this.onNotConfirmedNavigate));
      } else {
        server.accept(this.userId);
      }
      battleLinkActivatorService.navigateToBattleUrlWithoutAvailableBattle(this.battleData);
    }

    private function onConfirmedNavigate(param1:BattleLinkActivatorServiceEvent) : void {
      modalLoaderService.show();
      this.removeConfirmedNavigateEvent();
      server.accept(this.userId);
    }

    private function removeConfirmedNavigateEvent() : void {
      battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE,getFunctionWrapper(this.onConfirmedNavigate));
      battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE,getFunctionWrapper(this.onNotConfirmedNavigate));
    }

    private function onNotConfirmedNavigate(param1:BattleLinkActivatorServiceEvent) : void {
      this.removeConfirmedNavigateEvent();
      server.reject(this.userId);
    }

    private function onDead(param1:BattleLinkAliveEvent) : void {
      if(this.battleData.battleId != param1.battleId) {
        return;
      }
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_CANNOT_BE_FOUND_ALERT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      server.reject(this.userId);
    }

    private function onReject(param1:BattleInviteServiceEvent) : void {
      server.reject(param1.userId);
    }

    public function objectUnloaded() : void {
      battleInviteService.removeEventListener(BattleInviteServiceEvent.INVITE,getFunctionWrapper(this.onBattleInvite));
      battleInviteService.removeEventListener(BattleInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
      battleInviteService.removeEventListener(BattleInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
      battleLinkActivatorService.removeEventListener(BattleLinkAliveEvent.ALIVE,getFunctionWrapper(this.onAlive));
      battleLinkActivatorService.removeEventListener(BattleLinkAliveEvent.DEAD,getFunctionWrapper(this.onDead));
      friendInfoService.removeEventListener(FriendStateChangeEvent.CHANGE,getFunctionWrapper(this.onChangeFriendState));
    }

    public function notify(param1:Long, param2:BattleInviteMessage) : void {
      var local3:BattleInfoData = param2.battleData;
      notificationService.addNotification(new BattleInviteNotification(param1,createInviteBattleMessage(param2),createMapAndModeString(local3),local3));
    }

    private function onChangeFriendState(param1:FriendStateChangeEvent) : void {
      var local2:Boolean = param1.prevState == FriendState.ACCEPTED && param1.state != FriendState.ACCEPTED;
      if(local2) {
        if(param1.userId in this.inviteList) {
          this.rejected(param1.userId);
        }
      }
    }

    public function accepted(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_IS_JOINING_THE_BATTLE_AT_YOUR_INVITATION_LABEL)));
    }

    private function removeInvite(param1:Long) : void {
      delete this.inviteList[param1];
      battleInviteService.removeInvite(param1);
    }

    public function rejected(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_REFUSED_TO_JOIN_THE_BATTLE_AT_YOUR_INVITATION_LABEL)));
    }

    public function rejectedBattleNotFound(param1:Long) : void {
      this.removeInvite(param1);
      addNotificationBattleNotFound(param1);
    }

    public function rejectedInvitationToBattleDisabled(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_DISABLED_INVITES_LABEL)));
    }

    public function rejectedPanelNotLoaded(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_ENTERING_THE_GAME_LABEL)));
    }

    public function rejectedUserAlreadyInBattle(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_ALREADY_IN_THIS_BATTLE_LABEL)));
    }

    public function rejectedUserInMatchBattle(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,"Пользователь в матчмейкинге"));
    }

    public function rejectedUserOffline(param1:Long) : void {
      this.removeInvite(param1);
      notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_OFFLINE_LABEL)));
    }
  }
}
