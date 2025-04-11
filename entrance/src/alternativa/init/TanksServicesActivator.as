package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.tanks.bg.BackgroundService;
  import alternativa.tanks.bg.IBackgroundService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.loader.LoaderWindow;
  import alternativa.tanks.loader.ModalLoader;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import alternativa.tanks.newbieservice.NewbieUserServiceImpl;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.tracker.TrackerService;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import alternativa.tanks.ymservice.YandexMetricaServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.BlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.BlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.DialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.GroupInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.IGroupInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.BattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.OnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.UserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankServiceImpl;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.StorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;

  public class TanksServicesActivator implements IBundleActivator {
    public static var osgi:OSGi;

    public function TanksServicesActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      TanksServicesActivator.osgi = param1;
      var local2:IBackgroundService = new BackgroundService();
      param1.registerService(IStorageService,new StorageService(param1.createSharedObject("name"),param1.createSharedObject("accounts")));
      param1.registerService(IBackgroundService,local2);
      param1.registerService(IHelpService,new HelpService());
      param1.registerService(IBlurService,new BlurService());
      param1.registerService(ITrackerService,new TrackerService());
      param1.registerService(ILoaderWindowService,new LoaderWindow());
      param1.registerService(IModalLoaderService,new ModalLoader());
      param1.registerService(IUserInfoService,new UserInfoService());
      param1.registerService(IFriendInfoService,new FriendInfoService());
      param1.registerService(IFriendActionService,new FriendActionService());
      param1.registerService(IUserPropertiesService,new UserPropertiesService());
      param1.registerService(IDialogWindowsDispatcherService,new DialogWindowsDispatcherService());
      param1.registerService(IOnlineNotifierService,new OnlineNotifierService());
      param1.registerService(IBattleNotifierService,new BattleNotifierService());
      param1.registerService(IBattleInviteService,new BattleInviteService());
      param1.registerService(IBlockUserService,new BlockUserService());
      param1.registerService(TanksAddressService,new TanksAddressServiceImpl());
      param1.registerService(IBattleInfoService,new BattleInfoService());
      param1.registerService(IDialogsService,new DialogsService());
      param1.registerService(IUserProBattleService,new UserProBattleService());
      param1.registerService(BattleFormatUtil,new BattleFormatUtil());
      param1.registerService(PremiumService,new PremiumServiceImpl());
      param1.registerService(BattleUserPremiumService,new BattleUserPremiumServiceImpl());
      param1.registerService(RankService,new RankServiceImpl());
      param1.registerService(MatchmakingGroupService,new MatchmakingGroupServiceImpl());
      param1.registerService(UserPaymentActionsService,new UserPaymentActionsServiceImpl());
      param1.registerService(UserGarageActionsService,new UserGarageActionsServiceImpl());
      param1.registerService(UserBattleSelectActionsService,new UserBattleSelectActionsServiceImpl());
      param1.registerService(YandexMetricaService,new YandexMetricaServiceImpl());
      param1.registerService(NewbieUserService,new NewbieUserServiceImpl());
      param1.registerService(GroupInviteService,new GroupInviteServiceImpl());
      param1.registerService(IGroupInfoService,new GroupInfoService());
      local2.showBg();
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
