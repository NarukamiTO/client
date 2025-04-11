package projects.tanks.clients.fp10.libraries.tanksservicesflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.protocol.IProtocol;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import alternativa.tanks.newbieservice.NewbieUserServiceImpl;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.ymservice.YandexMetricaServiceImpl;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.client.fp10.core.service.transport.ITransportService;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.FriendsModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriendsAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriendsEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefreshAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefreshEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.formatbattle.EquipmentConstraintsNamingModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.accepted.FriendsAcceptedModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.acceptednotificator.FriendsAcceptedNotificatorModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.battleinvite.NotificationEnabledModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incoming.FriendsIncomingModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incomingnotificator.FriendsIncomingNotificatorModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.gpu.GPUDetector;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.gpu.GPUDetectorAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.gpu.GPUDetectorEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifierAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifierEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.logging.UserActionsLoggerModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.Notifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.NotifierAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.NotifierEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.OnlineNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.premium.PremiumNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.rank.RankNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.referrals.ReferralNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.socialnetworks.SNUidNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.uid.UidNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceedAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceedEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.proabonement.ProBattleNotifierModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.rankloader.RankLoaderModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect.ReconnectLauncher;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect.ReconnectModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.serverrestarttime.OnceADayActionModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckService;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckServiceAdapt;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckServiceEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.TimeOutTruncateConsumers;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.BlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.BlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.DialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendsInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.LobbyLayoutServiceBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.PieceWordDeclensionUtil;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegister:ModelRegistry;
      var modelRegisterAdapt:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(IStorageService,function(param1:Object):void {
        NewbieUserServiceImpl.storageService = IStorageService(param1);
      },function():IStorageService {
        return NewbieUserServiceImpl.storageService;
      });
      osgi.injectService(NewbieUserService,function(param1:Object):void {
        YandexMetricaServiceImpl.newbieUserService = NewbieUserService(param1);
      },function():NewbieUserService {
        return YandexMetricaServiceImpl.newbieUserService;
      });
      osgi.injectService(IFriendActionService,function(param1:Object):void {
        FriendsModel.friendsActionService = IFriendActionService(param1);
      },function():IFriendActionService {
        return FriendsModel.friendsActionService;
      });
      osgi.injectService(BattleFormatUtil,function(param1:Object):void {
        EquipmentConstraintsNamingModel.battleFormatUtil = BattleFormatUtil(param1);
      },function():BattleFormatUtil {
        return EquipmentConstraintsNamingModel.battleFormatUtil;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsAcceptedModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsAcceptedModel.friendsInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsAcceptedNotificatorModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsAcceptedNotificatorModel.friendsInfoService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        FriendsAcceptedNotificatorModel.logService = LogService(param1);
      },function():LogService {
        return FriendsAcceptedNotificatorModel.logService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        NotificationEnabledModel.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return NotificationEnabledModel.battleInviteService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsIncomingModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsIncomingModel.friendsInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsIncomingNotificatorModel.friendsInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsIncomingNotificatorModel.friendsInfoService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        FriendsIncomingNotificatorModel.logService = LogService(param1);
      },function():LogService {
        return FriendsIncomingNotificatorModel.logService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        UserNotifierModel.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return UserNotifierModel.userInfoService;
      });
      osgi.injectService(UserBattleSelectActionsService,function(param1:Object):void {
        UserActionsLoggerModel.battleSelectActionService = UserBattleSelectActionsService(param1);
      },function():UserBattleSelectActionsService {
        return UserActionsLoggerModel.battleSelectActionService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        UserActionsLoggerModel.changeScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return UserActionsLoggerModel.changeScreenService;
      });
      osgi.injectService(UserGarageActionsService,function(param1:Object):void {
        UserActionsLoggerModel.garageActionService = UserGarageActionsService(param1);
      },function():UserGarageActionsService {
        return UserActionsLoggerModel.garageActionService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        UserActionsLoggerModel.paymentActionService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return UserActionsLoggerModel.paymentActionService;
      });
      osgi.injectService(UserSettingsChangedService,function(param1:Object):void {
        UserActionsLoggerModel.settingsChangedService = UserSettingsChangedService(param1);
      },function():UserSettingsChangedService {
        return UserActionsLoggerModel.settingsChangedService;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        BattleLinkData.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return BattleLinkData.reconnectService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        BattleLinkData.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return BattleLinkData.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleLinkData.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleLinkData.userPropertiesService;
      });
      osgi.injectService(IBattleNotifierService,function(param1:Object):void {
        BattleNotifierModel.battleNotifierService = IBattleNotifierService(param1);
      },function():IBattleNotifierService {
        return BattleNotifierModel.battleNotifierService;
      });
      osgi.injectService(IOnlineNotifierService,function(param1:Object):void {
        OnlineNotifierModel.onlineNotifierService = IOnlineNotifierService(param1);
      },function():IOnlineNotifierService {
        return OnlineNotifierModel.onlineNotifierService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        PremiumNotifierModel.premiumService = PremiumService(param1);
      },function():PremiumService {
        return PremiumNotifierModel.premiumService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        RankNotifierModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return RankNotifierModel.userPropertiesService;
      });
      osgi.injectService(IUserProBattleService,function(param1:Object):void {
        ProBattleNotifierModel.userProBattleService = IUserProBattleService(param1);
      },function():IUserProBattleService {
        return ProBattleNotifierModel.userProBattleService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        RankLoaderModel.rankService = RankService(param1);
      },function():RankService {
        return RankLoaderModel.rankService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ReconnectLauncher.alertService = IAlertService(param1);
      },function():IAlertService {
        return ReconnectLauncher.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ReconnectLauncher.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ReconnectLauncher.battleInfoService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        ReconnectLauncher.dispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return ReconnectLauncher.dispatcherService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ReconnectLauncher.display = IDisplay(param1);
      },function():IDisplay {
        return ReconnectLauncher.display;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        ReconnectLauncher.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return ReconnectLauncher.launcherParams;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        ReconnectLauncher.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return ReconnectLauncher.loaderWindowService;
      });
      osgi.injectService(LobbyLayoutServiceBase,function(param1:Object):void {
        ReconnectLauncher.lobbyLayoutService = LobbyLayoutServiceBase(param1);
      },function():LobbyLayoutServiceBase {
        return ReconnectLauncher.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ReconnectLauncher.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ReconnectLauncher.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        ReconnectLauncher.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return ReconnectLauncher.modalLoaderService;
      });
      osgi.injectService(INetworkService,function(param1:Object):void {
        ReconnectLauncher.networkService = INetworkService(param1);
      },function():INetworkService {
        return ReconnectLauncher.networkService;
      });
      osgi.injectService(IProtocol,function(param1:Object):void {
        ReconnectLauncher.protocol = IProtocol(param1);
      },function():IProtocol {
        return ReconnectLauncher.protocol;
      });
      osgi.injectService(ITransportService,function(param1:Object):void {
        ReconnectLauncher.transportService = ITransportService(param1);
      },function():ITransportService {
        return ReconnectLauncher.transportService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        ReconnectLauncher.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return ReconnectLauncher.userInfoService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        ReconnectModel.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return ReconnectModel.addressService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ReconnectModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return ReconnectModel.alertService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        ReconnectModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return ReconnectModel.launcherParams;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ReconnectModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ReconnectModel.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        ReconnectModel.logService = LogService(param1);
      },function():LogService {
        return ReconnectModel.logService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        OnceADayActionModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return OnceADayActionModel.storageService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        TimeOutTruncateConsumers.logService = LogService(param1);
      },function():LogService {
        return TimeOutTruncateConsumers.logService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        TanksAddressServiceImpl.addressService = AddressService(param1);
      },function():AddressService {
        return TanksAddressServiceImpl.addressService;
      });
      osgi.injectService(ServerNumberToLocaleServerService,function(param1:Object):void {
        TanksAddressServiceImpl.serverNameService = ServerNumberToLocaleServerService(param1);
      },function():ServerNumberToLocaleServerService {
        return TanksAddressServiceImpl.serverNameService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        BattleInfoService.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return BattleInfoService.addressService;
      });
      osgi.injectService(ServerNumberToLocaleServerService,function(param1:Object):void {
        BattleInfoService.serverNameService = ServerNumberToLocaleServerService(param1);
      },function():ServerNumberToLocaleServerService {
        return BattleInfoService.serverNameService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleInfoService.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleInfoService.userPropertiesService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BlockUserService.storageService = IStorageService(param1);
      },function():IStorageService {
        return BlockUserService.storageService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        BlurService.helperService = IHelpService(param1);
      },function():IHelpService {
        return BlurService.helperService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ClanUserInfoServiceImpl.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ClanUserInfoServiceImpl.userPropertiesService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        DialogsService.blurService = IBlurService(param1);
      },function():IBlurService {
        return DialogsService.blurService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        DialogsService.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return DialogsService.dialogWindowsDispatcherService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        DialogsService.display = IDisplay(param1);
      },function():IDisplay {
        return DialogsService.display;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        DialogsService.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return DialogsService.loaderWindowService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        DialogWindow.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return DialogWindow.dialogService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        DialogWindow.display = IDisplay(param1);
      },function():IDisplay {
        return DialogWindow.display;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        FriendActionService.alertService = IAlertService(param1);
      },function():IAlertService {
        return FriendActionService.alertService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FriendActionService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FriendActionService.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        FriendsInfoLabelUpdater.logService = LogService(param1);
      },function():LogService {
        return FriendsInfoLabelUpdater.logService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleInviteService.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleInviteService.battleInfoService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        BattleInviteService.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return BattleInviteService.clanUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleInviteService.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleInviteService.friendInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleInviteService.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleInviteService.lobbyLayoutService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BubbleHelper.display = IDisplay(param1);
      },function():IDisplay {
        return BubbleHelper.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BubbleHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BubbleHelper.localeService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        UserGarageActionsServiceImpl.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return UserGarageActionsServiceImpl.trackerService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        ServerNumberToLocaleServerServiceImpl.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return ServerNumberToLocaleServerServiceImpl.addressService;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        ServerNumberToLocaleServerServiceImpl.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return ServerNumberToLocaleServerServiceImpl.reconnectService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        UserInfoLabelUpdater.logService = LogService(param1);
      },function():LogService {
        return UserInfoLabelUpdater.logService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        UserInfoService.premiumService = PremiumService(param1);
      },function():PremiumService {
        return UserInfoService.premiumService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        UserPropertiesService.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return UserPropertiesService.partnerService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        UserPropertiesService.rankService = RankService(param1);
      },function():RankService {
        return UserPropertiesService.rankService;
      });
      osgi.injectService(FullscreenStateService,function(param1:Object):void {
        AlertUtils.fullscreenStateService = FullscreenStateService(param1);
      },function():FullscreenStateService {
        return AlertUtils.fullscreenStateService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleFormatUtil.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleFormatUtil.localeService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        BattleInfoUtils.addressService = AddressService(param1);
      },function():AddressService {
        return BattleInfoUtils.addressService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleInfoUtils.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleInfoUtils.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        BattleInfoUtils.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return BattleInfoUtils.partnersService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PieceWordDeclensionUtil.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PieceWordDeclensionUtil.localeService;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new FriendsModel());
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(IFriends,IFriendsAdapt);
      modelRegisterAdapt.registerEvents(IFriends,IFriendsEvents);
      modelRegisterAdapt.registerAdapt(UserRefresh,UserRefreshAdapt);
      modelRegisterAdapt.registerEvents(UserRefresh,UserRefreshEvents);
      modelRegister.add(new EquipmentConstraintsNamingModel());
      modelRegister.add(new FriendsAcceptedModel());
      modelRegister.add(new FriendsAcceptedNotificatorModel());
      modelRegister.add(new NotificationEnabledModel());
      modelRegister.add(new FriendsIncomingModel());
      modelRegister.add(new FriendsIncomingNotificatorModel());
      modelRegisterAdapt.registerAdapt(GPUDetector,GPUDetectorAdapt);
      modelRegisterAdapt.registerEvents(GPUDetector,GPUDetectorEvents);
      modelRegisterAdapt.registerAdapt(UserNotifier,UserNotifierAdapt);
      modelRegisterAdapt.registerEvents(UserNotifier,UserNotifierEvents);
      modelRegister.add(new UserNotifierModel());
      modelRegister.add(new UserActionsLoggerModel());
      modelRegisterAdapt.registerAdapt(Notifier,NotifierAdapt);
      modelRegisterAdapt.registerEvents(Notifier,NotifierEvents);
      modelRegister.add(new BattleNotifierModel());
      modelRegister.add(new OnlineNotifierModel());
      modelRegister.add(new PremiumNotifierModel());
      modelRegister.add(new RankNotifierModel());
      modelRegister.add(new ReferralNotifierModel());
      modelRegister.add(new SNUidNotifierModel());
      modelRegister.add(new UidNotifierModel());
      modelRegisterAdapt.registerAdapt(PayModeProceed,PayModeProceedAdapt);
      modelRegisterAdapt.registerEvents(PayModeProceed,PayModeProceedEvents);
      modelRegister.add(new ProBattleNotifierModel());
      modelRegister.add(new RankLoaderModel());
      modelRegister.add(new ReconnectModel());
      modelRegister.add(new OnceADayActionModel());
      modelRegister.add(new UidCheckModel());
      modelRegisterAdapt.registerAdapt(UidCheckService,UidCheckServiceAdapt);
      modelRegisterAdapt.registerEvents(UidCheckService,UidCheckServiceEvents);
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
