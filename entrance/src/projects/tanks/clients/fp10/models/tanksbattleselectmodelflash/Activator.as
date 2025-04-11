package projects.tanks.clients.fp10.models.tanksbattleselectmodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.controllers.battlecreate.CreateBattleFormController;
  import alternativa.tanks.controllers.battleinfo.AbstractBattleInfoController;
  import alternativa.tanks.controllers.battleinfo.BattleInfoTeamController;
  import alternativa.tanks.controllers.battlelist.BattleListController;
  import alternativa.tanks.controllers.battlelist.BattleListItemParams;
  import alternativa.tanks.controllers.mathmacking.MatchmakingFormController;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.battle.BattleEntrance;
  import alternativa.tanks.model.battle.BattleEntranceAdapt;
  import alternativa.tanks.model.battle.BattleEntranceEvents;
  import alternativa.tanks.model.battle.BattleEntranceModel;
  import alternativa.tanks.model.battleselect.BattleSelectModel;
  import alternativa.tanks.model.battleselect.create.BattleCreateModel;
  import alternativa.tanks.model.buyproabonement.BuyProAbonementModel;
  import alternativa.tanks.model.info.BattleInfoModel;
  import alternativa.tanks.model.info.BattleInfoParams;
  import alternativa.tanks.model.info.BattleInfoParamsAdapt;
  import alternativa.tanks.model.info.BattleInfoParamsEvents;
  import alternativa.tanks.model.info.BattleParamsUtils;
  import alternativa.tanks.model.info.IBattleInfo;
  import alternativa.tanks.model.info.IBattleInfoAdapt;
  import alternativa.tanks.model.info.IBattleInfoEvents;
  import alternativa.tanks.model.info.ShowInfo;
  import alternativa.tanks.model.info.ShowInfoAdapt;
  import alternativa.tanks.model.info.ShowInfoEvents;
  import alternativa.tanks.model.info.dm.BattleDmInfoModel;
  import alternativa.tanks.model.info.param.BattleParamInfoModel;
  import alternativa.tanks.model.info.param.BattleParams;
  import alternativa.tanks.model.info.param.BattleParamsAdapt;
  import alternativa.tanks.model.info.param.BattleParamsEvents;
  import alternativa.tanks.model.info.team.BattleTeamInfo;
  import alternativa.tanks.model.info.team.BattleTeamInfoAdapt;
  import alternativa.tanks.model.info.team.BattleTeamInfoEvents;
  import alternativa.tanks.model.info.team.BattleTeamInfoModel;
  import alternativa.tanks.model.item.BattleFriendsListener;
  import alternativa.tanks.model.item.BattleFriendsListenerAdapt;
  import alternativa.tanks.model.item.BattleFriendsListenerEvents;
  import alternativa.tanks.model.item.dm.IBattleDMItem;
  import alternativa.tanks.model.item.dm.IBattleDMItemAdapt;
  import alternativa.tanks.model.item.dm.IBattleDMItemEvents;
  import alternativa.tanks.model.map.mapinfo.IMapInfo;
  import alternativa.tanks.model.map.mapinfo.IMapInfoAdapt;
  import alternativa.tanks.model.map.mapinfo.IMapInfoEvents;
  import alternativa.tanks.model.map.mapinfo.MapInfoModel;
  import alternativa.tanks.model.matchmaking.MatchmakingQueue;
  import alternativa.tanks.model.matchmaking.MatchmakingQueueAdapt;
  import alternativa.tanks.model.matchmaking.MatchmakingQueueEvents;
  import alternativa.tanks.model.matchmaking.MatchmakingQueueModel;
  import alternativa.tanks.model.matchmaking.group.MatchmakingGroupNotifyModel;
  import alternativa.tanks.model.matchmaking.grouplifecycle.MatchmakingGroupLifecycleModel;
  import alternativa.tanks.model.matchmaking.invitewindow.GroupInviteWindowModel;
  import alternativa.tanks.model.matchmaking.invitewindow.InviteWindowService;
  import alternativa.tanks.model.matchmaking.notify.MatchmakingGroupInviteModel;
  import alternativa.tanks.model.matchmaking.notify.MatchmakingNotifyModel;
  import alternativa.tanks.model.matchmaking.notify.MatchmakingTimeoutNotification;
  import alternativa.tanks.model.matchmaking.spectator.MatchmakingSpectatorEntranceModel;
  import alternativa.tanks.model.matchmaking.view.MatchmakingLayoutModel;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.battle.BattleFriendNotifier;
  import alternativa.tanks.service.battle.BattleUserInfoService;
  import alternativa.tanks.service.battle.IBattleUserInfoService;
  import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
  import alternativa.tanks.service.battleinfo.BattleInfoFormService;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.service.battlelist.BattleListFormService;
  import alternativa.tanks.service.battlelist.IBattleListFormService;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import alternativa.tanks.service.matchmaking.MatchmakingFormServiceImpl;
  import alternativa.tanks.service.matchmaking.MatchmakingGroupFormService;
  import alternativa.tanks.service.matchmaking.MatchmakingGroupInviteService;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsService;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.battlecreate.ChooseTypeBattleView;
  import alternativa.tanks.view.battlecreate.CreateBattleFormLabels;
  import alternativa.tanks.view.battlecreate.CreateBattleFormView;
  import alternativa.tanks.view.battleinfo.AbstractBattleInfoView;
  import alternativa.tanks.view.battleinfo.BattleInfoParamsView;
  import alternativa.tanks.view.battleinfo.LocaleBattleInfo;
  import alternativa.tanks.view.battlelist.BattleListView;
  import alternativa.tanks.view.battlelist.LocaleBattleList;
  import alternativa.tanks.view.battlelist.forms.BattleBigButton;
  import alternativa.tanks.view.mainview.BattleTypesPanel;
  import alternativa.tanks.view.mainview.MatchmakingLayout;
  import alternativa.tanks.view.mainview.button.LockedByRankButton;
  import alternativa.tanks.view.mainview.button.MainViewStarsEventButton;
  import alternativa.tanks.view.mainview.button.MatchmakingButton;
  import alternativa.tanks.view.mainview.groupinvite.GroupInviteWindow;
  import alternativa.tanks.view.mainview.groupinvite.InviteClanMembersList;
  import alternativa.tanks.view.mainview.groupinvite.InviteHeader;
  import alternativa.tanks.view.mainview.groupinvite.InviteToGroupList;
  import alternativa.tanks.view.mainview.grouplist.GroupList;
  import alternativa.tanks.view.mainview.grouplist.header.GroupHeader;
  import alternativa.tanks.view.mainview.grouplist.item.GroupUserItem;
  import alternativa.tanks.view.mainview.grouplist.item.GroupUsersDataProvider;
  import alternativa.tanks.view.mainview.grouplist.item.GroupUsersListRenderer;
  import alternativa.tanks.view.matchmaking.MatchmakingRegistrationDialog;
  import alternativa.tanks.view.matchmaking.group.invite.GroupInviteNotification;
  import alternativa.tanks.view.matchmaking.group.invite.ResponseGroupInviteNotification;
  import alternativa.tanks.view.matchmaking.quest.QuestButton;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
  import services.buttonbar.IButtonBarService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegisterAdapt:ModelRegistry;
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(IAchievementService,function(param1:Object):void {
        CreateBattleFormController.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return CreateBattleFormController.achievementService;
      });
      osgi.injectService(BattleFormatUtil,function(param1:Object):void {
        CreateBattleFormController.battleFormatUtil = BattleFormatUtil(param1);
      },function():BattleFormatUtil {
        return CreateBattleFormController.battleFormatUtil;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CreateBattleFormController.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CreateBattleFormController.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        CreateBattleFormController.storageService = IStorageService(param1);
      },function():IStorageService {
        return CreateBattleFormController.storageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        CreateBattleFormController.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return CreateBattleFormController.userPropertiesService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        AbstractBattleInfoController.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return AbstractBattleInfoController.clanUserInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        AbstractBattleInfoController.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return AbstractBattleInfoController.lobbyLayoutService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        AbstractBattleInfoController.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return AbstractBattleInfoController.userChangeGameScreenService;
      });
      osgi.injectService(IUserProBattleService,function(param1:Object):void {
        AbstractBattleInfoController.userProBattleService = IUserProBattleService(param1);
      },function():IUserProBattleService {
        return AbstractBattleInfoController.userProBattleService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        AbstractBattleInfoController.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return AbstractBattleInfoController.userPropertiesService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        BattleInfoTeamController.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return BattleInfoTeamController.userInfoService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        BattleListController.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return BattleListController.addressService;
      });
      osgi.injectService(IBattleCreateFormService,function(param1:Object):void {
        BattleListController.battleCreateFormService = IBattleCreateFormService(param1);
      },function():IBattleCreateFormService {
        return BattleListController.battleCreateFormService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleListController.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleListController.battleInfoFormService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleListController.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleListController.battleInfoService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleListController.battleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleListController.battleSelectActionsService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleListController.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleListController.lobbyLayoutService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        BattleListController.premiumService = PremiumService(param1);
      },function():PremiumService {
        return BattleListController.premiumService;
      });
      osgi.injectService(ServerNumberToLocaleServerService,function(param1:Object):void {
        BattleListController.serverNameService = ServerNumberToLocaleServerService(param1);
      },function():ServerNumberToLocaleServerService {
        return BattleListController.serverNameService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattleListController.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattleListController.storageService;
      });
      osgi.injectService(IUserProBattleService,function(param1:Object):void {
        BattleListController.userProBattleService = IUserProBattleService(param1);
      },function():IUserProBattleService {
        return BattleListController.userProBattleService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleListController.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleListController.userPropertiesService;
      });
      osgi.injectService(BattleFormatUtil,function(param1:Object):void {
        BattleListItemParams.battleFormatUtil = BattleFormatUtil(param1);
      },function():BattleFormatUtil {
        return BattleListItemParams.battleFormatUtil;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleListItemParams.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleListItemParams.battleInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleListItemParams.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleListItemParams.userPropertiesService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        MatchmakingFormController.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return MatchmakingFormController.dialogService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleEntranceModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return BattleEntranceModel.alertService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleEntranceModel.battleAlertService = IAlertService(param1);
      },function():IAlertService {
        return BattleEntranceModel.battleAlertService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleEntranceModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleEntranceModel.battleInfoFormService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        BattleEntranceModel.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return BattleEntranceModel.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleEntranceModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleEntranceModel.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        BattleEntranceModel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return BattleEntranceModel.modalLoaderService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BattleEntranceModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BattleEntranceModel.trackerService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleEntranceModel.userBattleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleEntranceModel.userBattleSelectActionsService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleSelectModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleSelectModel.battleInfoFormService;
      });
      osgi.injectService(IBattleListFormService,function(param1:Object):void {
        BattleSelectModel.battleListFormService = IBattleListFormService(param1);
      },function():IBattleListFormService {
        return BattleSelectModel.battleListFormService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BattleSelectModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BattleSelectModel.trackerService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleCreateModel.battleAlertService = IAlertService(param1);
      },function():IAlertService {
        return BattleCreateModel.battleAlertService;
      });
      osgi.injectService(IBattleCreateFormService,function(param1:Object):void {
        BattleCreateModel.battleCreateFormService = IBattleCreateFormService(param1);
      },function():IBattleCreateFormService {
        return BattleCreateModel.battleCreateFormService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleCreateModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleCreateModel.localeService;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        BattleCreateModel.modelRegistry = ModelRegistry(param1);
      },function():ModelRegistry {
        return BattleCreateModel.modelRegistry;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BattleCreateModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BattleCreateModel.trackerService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleCreateModel.userBattleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleCreateModel.userBattleSelectActionsService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BuyProAbonementModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BuyProAbonementModel.battleInfoFormService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleInfoModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return BattleInfoModel.alertService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleInfoModel.battleAlertService = IAlertService(param1);
      },function():IAlertService {
        return BattleInfoModel.battleAlertService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleInfoModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleInfoModel.battleInfoFormService;
      });
      osgi.injectService(IBattleListFormService,function(param1:Object):void {
        BattleInfoModel.battleListFormService = IBattleListFormService(param1);
      },function():IBattleListFormService {
        return BattleInfoModel.battleListFormService;
      });
      osgi.injectService(IBattleUserInfoService,function(param1:Object):void {
        BattleInfoModel.battleUserInfoService = IBattleUserInfoService(param1);
      },function():IBattleUserInfoService {
        return BattleInfoModel.battleUserInfoService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        BattleInfoModel.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return BattleInfoModel.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleInfoModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleInfoModel.localeService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BattleInfoModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BattleInfoModel.trackerService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleInfoModel.userBattleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleInfoModel.userBattleSelectActionsService;
      });
      osgi.injectService(IBattleUserInfoService,function(param1:Object):void {
        BattleParamsUtils.battleUserInfoService = IBattleUserInfoService(param1);
      },function():IBattleUserInfoService {
        return BattleParamsUtils.battleUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleParamsUtils.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleParamsUtils.friendsInfoService;
      });
      osgi.injectService(ServerNumberToLocaleServerService,function(param1:Object):void {
        BattleParamsUtils.serverNameService = ServerNumberToLocaleServerService(param1);
      },function():ServerNumberToLocaleServerService {
        return BattleParamsUtils.serverNameService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleDmInfoModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleDmInfoModel.battleInfoFormService;
      });
      osgi.injectService(IBattleListFormService,function(param1:Object):void {
        BattleDmInfoModel.battleListFormService = IBattleListFormService(param1);
      },function():IBattleListFormService {
        return BattleDmInfoModel.battleListFormService;
      });
      osgi.injectService(IBattleUserInfoService,function(param1:Object):void {
        BattleDmInfoModel.battleUserInfoService = IBattleUserInfoService(param1);
      },function():IBattleUserInfoService {
        return BattleDmInfoModel.battleUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleDmInfoModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleDmInfoModel.friendsInfoService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleTeamInfoModel.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleTeamInfoModel.battleInfoFormService;
      });
      osgi.injectService(IBattleListFormService,function(param1:Object):void {
        BattleTeamInfoModel.battleListFormService = IBattleListFormService(param1);
      },function():IBattleListFormService {
        return BattleTeamInfoModel.battleListFormService;
      });
      osgi.injectService(IBattleUserInfoService,function(param1:Object):void {
        BattleTeamInfoModel.battleUserInfoService = IBattleUserInfoService(param1);
      },function():IBattleUserInfoService {
        return BattleTeamInfoModel.battleUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleTeamInfoModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleTeamInfoModel.friendsInfoService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingQueueModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingQueueModel.matchmakingFormService;
      });
      osgi.injectService(MatchmakingGroupFormService,function(param1:Object):void {
        MatchmakingGroupNotifyModel.matchmakingFormService = MatchmakingGroupFormService(param1);
      },function():MatchmakingGroupFormService {
        return MatchmakingGroupNotifyModel.matchmakingFormService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        MatchmakingGroupNotifyModel.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return MatchmakingGroupNotifyModel.matchmakingGroupService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingGroupLifecycleModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingGroupLifecycleModel.matchmakingFormService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        MatchmakingGroupLifecycleModel.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return MatchmakingGroupLifecycleModel.matchmakingGroupService;
      });
      osgi.injectService(MatchmakingGroupInviteService,function(param1:Object):void {
        GroupInviteWindowModel.inviteService = MatchmakingGroupInviteService(param1);
      },function():MatchmakingGroupInviteService {
        return GroupInviteWindowModel.inviteService;
      });
      osgi.injectService(InviteWindowService,function(param1:Object):void {
        GroupInviteWindowModel.inviteWindowService = InviteWindowService(param1);
      },function():InviteWindowService {
        return GroupInviteWindowModel.inviteWindowService;
      });
      osgi.injectService(InviteWindowService,function(param1:Object):void {
        MatchmakingGroupInviteModel.groupInviteWindowService = InviteWindowService(param1);
      },function():InviteWindowService {
        return MatchmakingGroupInviteModel.groupInviteWindowService;
      });
      osgi.injectService(GroupInviteService,function(param1:Object):void {
        MatchmakingGroupInviteModel.inviteService = GroupInviteService(param1);
      },function():GroupInviteService {
        return MatchmakingGroupInviteModel.inviteService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        MatchmakingGroupInviteModel.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return MatchmakingGroupInviteModel.matchmakingGroupService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        MatchmakingGroupInviteModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return MatchmakingGroupInviteModel.notificationService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        MatchmakingNotifyModel.loaderService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return MatchmakingNotifyModel.loaderService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        MatchmakingNotifyModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return MatchmakingNotifyModel.lobbyLayoutService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingNotifyModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingNotifyModel.matchmakingFormService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        MatchmakingNotifyModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return MatchmakingNotifyModel.notificationService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MatchmakingTimeoutNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MatchmakingTimeoutNotification.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        MatchmakingSpectatorEntranceModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return MatchmakingSpectatorEntranceModel.alertService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingSpectatorEntranceModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingSpectatorEntranceModel.matchmakingFormService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingLayoutModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingLayoutModel.matchmakingFormService;
      });
      osgi.injectService(IBattleUserInfoService,function(param1:Object):void {
        BattleFriendNotifier.battleUserInfoService = IBattleUserInfoService(param1);
      },function():IBattleUserInfoService {
        return BattleFriendNotifier.battleUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleFriendNotifier.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleFriendNotifier.friendsInfoService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        BattleUserInfoService.logService = LogService(param1);
      },function():LogService {
        return BattleUserInfoService.logService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BattleInfoFormService.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BattleInfoFormService.trackerService;
      });
      osgi.injectService(IBattleCreateFormService,function(param1:Object):void {
        BattleListFormService.battleCreateFormService = IBattleCreateFormService(param1);
      },function():IBattleCreateFormService {
        return BattleListFormService.battleCreateFormService;
      });
      osgi.injectService(IBattleInfoFormService,function(param1:Object):void {
        BattleListFormService.battleInfoFormService = IBattleInfoFormService(param1);
      },function():IBattleInfoFormService {
        return BattleListFormService.battleInfoFormService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        MatchmakingFormServiceImpl.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return MatchmakingFormServiceImpl.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MatchmakingFormServiceImpl.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MatchmakingFormServiceImpl.localeService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        MatchmakingFormServiceImpl.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return MatchmakingFormServiceImpl.matchmakingGroupService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        MatchmakingFormServiceImpl.storageService = IStorageService(param1);
      },function():IStorageService {
        return MatchmakingFormServiceImpl.storageService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChooseTypeBattleView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChooseTypeBattleView.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CreateBattleFormLabels.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CreateBattleFormLabels.localeService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        CreateBattleFormView.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return CreateBattleFormView.clanUserInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        CreateBattleFormView.display = IDisplay(param1);
      },function():IDisplay {
        return CreateBattleFormView.display;
      });
      osgi.injectService(ITimeUnitService,function(param1:Object):void {
        CreateBattleFormView.timeUnitService = ITimeUnitService(param1);
      },function():ITimeUnitService {
        return CreateBattleFormView.timeUnitService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        CreateBattleFormView.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return CreateBattleFormView.trackerService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        AbstractBattleInfoView.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return AbstractBattleInfoView.achievementService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        AbstractBattleInfoView.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return AbstractBattleInfoView.battleInfoService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        AbstractBattleInfoView.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return AbstractBattleInfoView.clanUserInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AbstractBattleInfoView.display = IDisplay(param1);
      },function():IDisplay {
        return AbstractBattleInfoView.display;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        AbstractBattleInfoView.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return AbstractBattleInfoView.lobbyLayoutService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        AbstractBattleInfoView.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return AbstractBattleInfoView.modalLoaderService;
      });
      osgi.injectService(IUserProBattleService,function(param1:Object):void {
        AbstractBattleInfoView.userProBattleService = IUserProBattleService(param1);
      },function():IUserProBattleService {
        return AbstractBattleInfoView.userProBattleService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        AbstractBattleInfoView.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return AbstractBattleInfoView.userPropertiesService;
      });
      osgi.injectService(BattleFormatUtil,function(param1:Object):void {
        BattleInfoParamsView.battleFormatUtil = BattleFormatUtil(param1);
      },function():BattleFormatUtil {
        return BattleInfoParamsView.battleFormatUtil;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleInfoParamsView.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleInfoParamsView.battleInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleInfoParamsView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleInfoParamsView.localeService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleInfoParamsView.userBattleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleInfoParamsView.userBattleSelectActionsService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleInfoParamsView.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleInfoParamsView.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LocaleBattleInfo.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LocaleBattleInfo.localeService;
      });
      osgi.injectService(IBattleCreateFormService,function(param1:Object):void {
        BattleListView.battleCreateFormService = IBattleCreateFormService(param1);
      },function():IBattleCreateFormService {
        return BattleListView.battleCreateFormService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        BattleListView.battleSelectActionsService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return BattleListView.battleSelectActionsService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleListView.display = IDisplay(param1);
      },function():IDisplay {
        return BattleListView.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        BattleListView.helpService = IHelpService(param1);
      },function():IHelpService {
        return BattleListView.helpService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleListView.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleListView.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleListView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleListView.localeService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        BattleListView.panelView = IPanelView(param1);
      },function():IPanelView {
        return BattleListView.panelView;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        BattleListView.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return BattleListView.reconnectService;
      });
      osgi.injectService(IUserProBattleService,function(param1:Object):void {
        BattleListView.userProBattleService = IUserProBattleService(param1);
      },function():IUserProBattleService {
        return BattleListView.userProBattleService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleListView.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleListView.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LocaleBattleList.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LocaleBattleList.localeService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        BattleBigButton.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return BattleBigButton.moneyService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        BattleTypesPanel.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return BattleTypesPanel.achievementService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        BattleTypesPanel.challengeInfoService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return BattleTypesPanel.challengeInfoService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        MatchmakingLayout.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return MatchmakingLayout.achievementService;
      });
      osgi.injectService(IButtonBarService,function(param1:Object):void {
        MatchmakingLayout.buttonBarService = IButtonBarService(param1);
      },function():IButtonBarService {
        return MatchmakingLayout.buttonBarService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        MatchmakingLayout.display = IDisplay(param1);
      },function():IDisplay {
        return MatchmakingLayout.display;
      });
      osgi.injectService(MatchmakingGroupInviteService,function(param1:Object):void {
        MatchmakingLayout.groupInviteService = MatchmakingGroupInviteService(param1);
      },function():MatchmakingGroupInviteService {
        return MatchmakingLayout.groupInviteService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MatchmakingLayout.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MatchmakingLayout.localeService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        MatchmakingLayout.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return MatchmakingLayout.matchmakingGroupService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        MatchmakingLayout.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return MatchmakingLayout.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LockedByRankButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LockedByRankButton.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        LockedByRankButton.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return LockedByRankButton.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MainViewStarsEventButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MainViewStarsEventButton.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MatchmakingButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MatchmakingButton.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        GroupInviteWindow.alertService = IAlertService(param1);
      },function():IAlertService {
        return GroupInviteWindow.alertService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        GroupInviteWindow.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return GroupInviteWindow.clanUserInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GroupInviteWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GroupInviteWindow.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        GroupInviteWindow.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return GroupInviteWindow.partnerService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        GroupInviteWindow.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return GroupInviteWindow.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        InviteClanMembersList.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return InviteClanMembersList.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        InviteHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return InviteHeader.localeService;
      });
      osgi.injectService(IBattleNotifierService,function(param1:Object):void {
        InviteToGroupList.battleNotifierService = IBattleNotifierService(param1);
      },function():IBattleNotifierService {
        return InviteToGroupList.battleNotifierService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        InviteToGroupList.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return InviteToGroupList.friendInfoService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        InviteToGroupList.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return InviteToGroupList.matchmakingGroupService;
      });
      osgi.injectService(IOnlineNotifierService,function(param1:Object):void {
        InviteToGroupList.onlineNotifierService = IOnlineNotifierService(param1);
      },function():IOnlineNotifierService {
        return InviteToGroupList.onlineNotifierService;
      });
      osgi.injectService(SNFriendsService,function(param1:Object):void {
        InviteToGroupList.snFriendsService = SNFriendsService(param1);
      },function():SNFriendsService {
        return InviteToGroupList.snFriendsService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        GroupList.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return GroupList.matchmakingGroupService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GroupHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GroupHeader.localeService;
      });
      osgi.injectService(MatchmakingGroupInviteService,function(param1:Object):void {
        GroupUserItem.inviteService = MatchmakingGroupInviteService(param1);
      },function():MatchmakingGroupInviteService {
        return GroupUserItem.inviteService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GroupUserItem.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GroupUserItem.localeService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        GroupUserItem.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return GroupUserItem.matchmakingGroupService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        GroupUserItem.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return GroupUserItem.userInfoService;
      });
      osgi.injectService(MatchmakingGroupService,function(param1:Object):void {
        GroupUsersDataProvider.matchmakingGroupService = MatchmakingGroupService(param1);
      },function():MatchmakingGroupService {
        return GroupUsersDataProvider.matchmakingGroupService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GroupUsersListRenderer.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GroupUsersListRenderer.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MatchmakingRegistrationDialog.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MatchmakingRegistrationDialog.localeService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingRegistrationDialog.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingRegistrationDialog.matchmakingFormService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        GroupInviteNotification.battleAlertService = IAlertService(param1);
      },function():IAlertService {
        return GroupInviteNotification.battleAlertService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        GroupInviteNotification.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return GroupInviteNotification.dialogWindowsDispatcherService;
      });
      osgi.injectService(GroupInviteService,function(param1:Object):void {
        GroupInviteNotification.inviteService = GroupInviteService(param1);
      },function():GroupInviteService {
        return GroupInviteNotification.inviteService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        GroupInviteNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return GroupInviteNotification.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        GroupInviteNotification.storageService = IStorageService(param1);
      },function():IStorageService {
        return GroupInviteNotification.storageService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ResponseGroupInviteNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ResponseGroupInviteNotification.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QuestButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QuestButton.localeService;
      });
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(BattleEntrance,BattleEntranceAdapt);
      modelRegisterAdapt.registerEvents(BattleEntrance,BattleEntranceEvents);
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new BattleEntranceModel());
      modelRegister.add(new BattleSelectModel());
      modelRegister.add(new BattleCreateModel());
      modelRegister.add(new BuyProAbonementModel());
      modelRegister.add(new BattleInfoModel());
      modelRegisterAdapt.registerAdapt(BattleInfoParams,BattleInfoParamsAdapt);
      modelRegisterAdapt.registerEvents(BattleInfoParams,BattleInfoParamsEvents);
      modelRegisterAdapt.registerAdapt(IBattleInfo,IBattleInfoAdapt);
      modelRegisterAdapt.registerEvents(IBattleInfo,IBattleInfoEvents);
      modelRegisterAdapt.registerAdapt(ShowInfo,ShowInfoAdapt);
      modelRegisterAdapt.registerEvents(ShowInfo,ShowInfoEvents);
      modelRegister.add(new BattleDmInfoModel());
      modelRegister.add(new BattleParamInfoModel());
      modelRegisterAdapt.registerAdapt(BattleParams,BattleParamsAdapt);
      modelRegisterAdapt.registerEvents(BattleParams,BattleParamsEvents);
      modelRegisterAdapt.registerAdapt(BattleTeamInfo,BattleTeamInfoAdapt);
      modelRegisterAdapt.registerEvents(BattleTeamInfo,BattleTeamInfoEvents);
      modelRegister.add(new BattleTeamInfoModel());
      modelRegisterAdapt.registerAdapt(BattleFriendsListener,BattleFriendsListenerAdapt);
      modelRegisterAdapt.registerEvents(BattleFriendsListener,BattleFriendsListenerEvents);
      modelRegisterAdapt.registerAdapt(IBattleDMItem,IBattleDMItemAdapt);
      modelRegisterAdapt.registerEvents(IBattleDMItem,IBattleDMItemEvents);
      modelRegisterAdapt.registerAdapt(IMapInfo,IMapInfoAdapt);
      modelRegisterAdapt.registerEvents(IMapInfo,IMapInfoEvents);
      modelRegister.add(new MapInfoModel());
      modelRegisterAdapt.registerAdapt(MatchmakingQueue,MatchmakingQueueAdapt);
      modelRegisterAdapt.registerEvents(MatchmakingQueue,MatchmakingQueueEvents);
      modelRegister.add(new MatchmakingQueueModel());
      modelRegister.add(new MatchmakingGroupNotifyModel());
      modelRegister.add(new MatchmakingGroupLifecycleModel());
      modelRegister.add(new GroupInviteWindowModel());
      modelRegister.add(new MatchmakingGroupInviteModel());
      modelRegister.add(new MatchmakingNotifyModel());
      modelRegister.add(new MatchmakingSpectatorEntranceModel());
      modelRegister.add(new MatchmakingLayoutModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
