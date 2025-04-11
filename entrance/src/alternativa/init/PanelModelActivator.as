package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.tanks.gui.error.CustomErrorWindow;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseService;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseServiceImpl;
  import alternativa.tanks.model.coin.CoinInfoService;
  import alternativa.tanks.model.coin.CoinInfoServiceImpl;
  import alternativa.tanks.model.panel.CapabilitiesDumper;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowServiceImpl;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentService;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentServiceImp;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierService;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierServiceImpl;
  import alternativa.tanks.model.quest.challenge.ChallengesViewService;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoService;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoServiceImpl;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import alternativa.tanks.model.quest.common.gui.window.QuestWindow;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierServiceImpl;
  import alternativa.tanks.model.quest.daily.DailyQuestsService;
  import alternativa.tanks.model.quest.weekly.WeeklyQuestsService;
  import alternativa.tanks.service.achievement.AchievementService;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.battlelinkactivator.BattleLinkActivatorService;
  import alternativa.tanks.service.country.CountryService;
  import alternativa.tanks.service.country.CountryServiceImpl;
  import alternativa.tanks.service.fps.FPSService;
  import alternativa.tanks.service.fps.FPSServiceImpl;
  import alternativa.tanks.service.logging.UserChangeGameScreenServiceImpl;
  import alternativa.tanks.service.logging.UserSettingsChangedServiceImpl;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.tanks.service.money.MoneyService;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import alternativa.tanks.service.notificationcategories.NotificationGarageCategoriesService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.panel.PanelView;
  import alternativa.tanks.service.payment.IPaymentPackagesService;
  import alternativa.tanks.service.payment.IPaymentService;
  import alternativa.tanks.service.payment.PaymentPackagesService;
  import alternativa.tanks.service.payment.PaymentService;
  import alternativa.tanks.service.payment.display.PaymentDisplayServiceImpl;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteService;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteServiceImpl;
  import alternativa.tanks.service.referrals.ReferralsService;
  import alternativa.tanks.service.referrals.ReferralsServiceImpl;
  import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperService;
  import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperServiceImpl;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierServiceImpl;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsService;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.service.settings.keybinding.KeysBindingServiceImpl;
  import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
  import alternativa.tanks.service.socialnetwork.SocialNetworkPanelService;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsService;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsServiceImpl;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsServiceImpl;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;

  public class PanelModelActivator implements IBundleActivator {
    private var capabilitiesDumper:CapabilitiesDumper = new CapabilitiesDumper();

    public function PanelModelActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      param1.registerService(IPanelView,new PanelView());
      param1.registerService(ISettingsService,new SettingsService());
      param1.registerService(IMoneyService,new MoneyService());
      param1.registerService(IAchievementService,new AchievementService());
      param1.registerService(IPaymentService,new PaymentService());
      param1.registerService(ISocialNetworkPanelService,new SocialNetworkPanelService());
      param1.registerService(UpgradingItemsService,new UpgradingItemsServiceImpl());
      param1.registerService(FPSService,new FPSServiceImpl());
      param1.registerService(IBattleLinkActivatorService,new BattleLinkActivatorService());
      param1.registerService(IPaymentPackagesService,new PaymentPackagesService());
      param1.registerService(PaymentCompleteService,new PaymentCompleteServiceImpl());
      param1.registerService(QuestNotifierService,new QuestNotifierServiceImpl());
      param1.registerService(CountryService,new CountryServiceImpl());
      param1.registerService(PaymentDisplayService,new PaymentDisplayServiceImpl());
      param1.registerService(UserChangeGameScreenService,new UserChangeGameScreenServiceImpl());
      param1.registerService(UserSettingsChangedService,new UserSettingsChangedServiceImpl());
      param1.registerService(INotificationGarageCategoriesService,new NotificationGarageCategoriesService());
      param1.registerService(PaymentWindowService,new PaymentWindowServiceImpl());
      param1.registerService(ShopNotifierService,new ShopNotifierServiceImpl());
      param1.registerService(KeysBindingService,new KeysBindingServiceImpl());
      param1.registerService(ReferralsService,new ReferralsServiceImpl());
      param1.registerService(SNFriendsService,new SNFriendsServiceImpl());
      param1.registerService(NewReferralsNotifierService,new NewReferralsNotifierServiceImpl());
      param1.registerService(ProcessedPaymentService,new ProcessedPaymentServiceImp());
      param1.registerService(ReferralsButtonHelperService,new ReferralsButtonHelperServiceImpl());
      param1.registerService(StarsInfoService,new StarsInfoServiceImpl());
      param1.registerService(CoinInfoService,new CoinInfoServiceImpl());
      var local2:QuestWindow = new QuestWindow();
      param1.registerService(MissionsWindowsService,local2);
      param1.registerService(DailyQuestsService,local2.getDailyQuestsTab());
      param1.registerService(WeeklyQuestsService,local2.getWeeklyQuestsTab());
      param1.registerService(ChallengesViewService,local2.getChallengesTab());
      param1.registerService(BattlePassPurchaseService,new BattlePassPurchaseServiceImpl());
      IDumpService(param1.getService(IDumpService)).registerDumper(this.capabilitiesDumper);
      IErrorMessageService(param1.getService(IErrorMessageService)).setMessageBox(new CustomErrorWindow(param1));
    }

    public function stop(param1:OSGi) : void {
      IDumpService(param1.getService(IDumpService)).unregisterDumper(this.capabilitiesDumper.dumperName);
      this.capabilitiesDumper = null;
      param1.unregisterService(IPanelView);
      param1.unregisterService(ISettingsService);
      param1.unregisterService(IMoneyService);
      param1.unregisterService(IAchievementService);
      param1.unregisterService(IPaymentService);
      param1.unregisterService(ISocialNetworkPanelService);
      param1.unregisterService(IPaymentPackagesService);
      param1.unregisterService(UpgradingItemsService);
      param1.unregisterService(FPSService);
      param1.unregisterService(QuestNotifierService);
      param1.unregisterService(CountryService);
      param1.unregisterService(UserChangeGameScreenService);
      param1.unregisterService(UserSettingsChangedService);
      param1.unregisterService(PaymentWindowService);
      param1.unregisterService(KeysBindingService);
      param1.unregisterService(ProcessedPaymentService);
      param1.unregisterService(ReferralsButtonHelperService);
      param1.unregisterService(BattlePassPurchaseService);
    }
  }
}
