package projects.tanks.clients.flash.commons.osgi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengesServiceImpl;
  import projects.tanks.clients.flash.commons.models.challenge.shopitems.ChallengeShopItems;
  import projects.tanks.clients.flash.commons.models.challenge.shopitems.ChallengeShopItemsServiceImpl;
  import projects.tanks.clients.flash.commons.services.autobattleenter.AutomaticEnterExitService;
  import projects.tanks.clients.flash.commons.services.externalauth.ExternalAuthParamsService;
  import projects.tanks.clients.flash.commons.services.externalauth.ExternalAuthParamsServiceImpl;
  import projects.tanks.clients.flash.commons.services.fullscreen.FullscreenServiceImpl;
  import projects.tanks.clients.flash.commons.services.fullscreen.FullscreenStateServiceImpl;
  import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.notification.NotificationService;
  import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
  import projects.tanks.clients.flash.commons.services.notification.sound.NotificationSoundService;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
  import projects.tanks.clients.flash.commons.services.serverhalt.ServerHaltService;
  import projects.tanks.clients.flash.commons.services.stagequality.IStageQualityService;
  import projects.tanks.clients.flash.commons.services.stagequality.StageQualityService;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.flash.commons.services.timeunit.TimeUnitService;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.LobbyLayoutServiceBase;

  public class Activator implements IBundleActivator {
    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local2:ILobbyLayoutService = new LobbyLayoutService();
      param1.registerService(ILobbyLayoutService,local2);
      param1.registerService(LobbyLayoutServiceBase,local2);
      param1.registerService(INotificationService,new NotificationService(local2));
      param1.registerService(IServerHaltService,new ServerHaltService());
      param1.registerService(IValidateService,new ValidateService());
      param1.registerService(AutomaticEnterExitService,new AutomaticEnterExitService(param1));
      param1.registerService(INotificationSoundService,new NotificationSoundService());
      param1.registerService(IStageQualityService,new StageQualityService(local2));
      param1.registerService(ITimeUnitService,new TimeUnitService());
      param1.registerService(ExternalAuthParamsService,new ExternalAuthParamsServiceImpl());
      var local3:IDisplay = IDisplay(OSGi.getInstance().getService(IDisplay));
      var local4:ILauncherParams = ILauncherParams(OSGi.getInstance().getService(ILauncherParams));
      var local5:FullscreenServiceImpl = new FullscreenServiceImpl(local3,local4);
      param1.registerService(FullscreenService,local5);
      param1.registerService(FullscreenStateService,new FullscreenStateServiceImpl(local3,local5.isAvailable()));
      param1.registerService(ChallengeInfoService,new ChallengesServiceImpl());
      param1.registerService(ChallengeShopItems,new ChallengeShopItemsServiceImpl());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
