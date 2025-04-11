package projects.tanks.clients.flash.commonsflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.models.alert.AlertModel;
  import projects.tanks.clients.flash.commons.models.battlelinkactivator.BattleLinkActivatorModel;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptchaAdapt;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptchaEvents;
  import projects.tanks.clients.flash.commons.models.captcha.ServerCaptchaModel;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeTimeModel;
  import projects.tanks.clients.flash.commons.models.coloring.ColoringModel;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.commons.models.coloring.IColoringAdapt;
  import projects.tanks.clients.flash.commons.models.coloring.IColoringEvents;
  import projects.tanks.clients.flash.commons.models.detach.Detach;
  import projects.tanks.clients.flash.commons.models.detach.DetachAdapt;
  import projects.tanks.clients.flash.commons.models.detach.DetachEvents;
  import projects.tanks.clients.flash.commons.models.detach.DetachModel;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApi;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApiAdapt;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApiEvents;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApiModel;
  import projects.tanks.clients.flash.commons.models.gpu.GPUDetectorModel;
  import projects.tanks.clients.flash.commons.models.layout.ILobbyLayout;
  import projects.tanks.clients.flash.commons.models.layout.ILobbyLayoutAdapt;
  import projects.tanks.clients.flash.commons.models.layout.ILobbyLayoutEvents;
  import projects.tanks.clients.flash.commons.models.layout.LobbyLayoutModel;
  import projects.tanks.clients.flash.commons.models.layout.notify.ILobbyLayoutNotify;
  import projects.tanks.clients.flash.commons.models.layout.notify.ILobbyLayoutNotifyAdapt;
  import projects.tanks.clients.flash.commons.models.layout.notify.ILobbyLayoutNotifyEvents;
  import projects.tanks.clients.flash.commons.models.layout.notify.LobbyLayoutNotifyModel;
  import projects.tanks.clients.flash.commons.models.moveusertoserver.MoveUserToServerModel;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwner;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwnerAdapt;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwnerEvents;
  import projects.tanks.clients.flash.commons.models.runtime.DataOwnerModel;
  import projects.tanks.clients.flash.commons.models.serverhalt.ServerHaltModel;
  import projects.tanks.clients.flash.commons.services.autobattleenter.AutomaticEnterExitService;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
  import projects.tanks.clients.flash.commons.services.nameutils.SocialNetworkNameUtils;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
  import projects.tanks.clients.flash.commons.services.stagequality.StageQualityService;
  import projects.tanks.clients.flash.commons.services.timeunit.TimeUnitService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

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
      osgi.injectService(IAlertService,function(param1:Object):void {
        AlertModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return AlertModel.alertService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AlertModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AlertModel.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleLinkActivatorModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return BattleLinkActivatorModel.alertService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        BattleLinkActivatorModel.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return BattleLinkActivatorModel.battleLinkActivatorService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleLinkActivatorModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleLinkActivatorModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleLinkActivatorModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleLinkActivatorModel.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattleLinkActivatorModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattleLinkActivatorModel.storageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleLinkActivatorModel.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleLinkActivatorModel.userPropertyService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        ChallengeTimeModel.challengesService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return ChallengeTimeModel.challengesService;
      });
      osgi.injectService(ResourceRegistry,function(param1:Object):void {
        ColoringModel.resourceRegistry = ResourceRegistry(param1);
      },function():ResourceRegistry {
        return ColoringModel.resourceRegistry;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        GPUDetectorModel.display = IDisplay(param1);
      },function():IDisplay {
        return GPUDetectorModel.display;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        GPUDetectorModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return GPUDetectorModel.launcherParams;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        LobbyLayoutModel.battleInfoSerivce = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return LobbyLayoutModel.battleInfoSerivce;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        LobbyLayoutModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return LobbyLayoutModel.lobbyLayoutService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        LobbyLayoutModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return LobbyLayoutModel.storageService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        LobbyLayoutModel.tanksAddressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return LobbyLayoutModel.tanksAddressService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        LobbyLayoutNotifyModel.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return LobbyLayoutNotifyModel.loaderWindowService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        LobbyLayoutNotifyModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return LobbyLayoutNotifyModel.lobbyLayoutService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        LobbyLayoutNotifyModel.logService = LogService(param1);
      },function():LogService {
        return LobbyLayoutNotifyModel.logService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        LobbyLayoutNotifyModel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return LobbyLayoutNotifyModel.modalLoaderService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        LobbyLayoutNotifyModel.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return LobbyLayoutNotifyModel.ymService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        MoveUserToServerModel.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return MoveUserToServerModel.addressService;
      });
      osgi.injectService(IServerHaltService,function(param1:Object):void {
        ServerHaltModel.serverHaltService = IServerHaltService(param1);
      },function():IServerHaltService {
        return ServerHaltModel.serverHaltService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        AutomaticEnterExitService.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return AutomaticEnterExitService.lobbyLayoutService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        AutomaticEnterExitService.logService = LogService(param1);
      },function():LogService {
        return AutomaticEnterExitService.logService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        AutomaticEnterExitService.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return AutomaticEnterExitService.paymentDisplayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DateFormatter.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DateFormatter.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        DateFormatter.logService = LogService(param1);
      },function():LogService {
        return DateFormatter.logService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        LobbyLayoutService.alertService = IAlertService(param1);
      },function():IAlertService {
        return LobbyLayoutService.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        LobbyLayoutService.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return LobbyLayoutService.battleInfoService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        LobbyLayoutService.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return LobbyLayoutService.dialogWindowsDispatcherService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LobbyLayoutService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LobbyLayoutService.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        LobbyLayoutService.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return LobbyLayoutService.partnersService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        LobbyLayoutService.storageService = IStorageService(param1);
      },function():IStorageService {
        return LobbyLayoutService.storageService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        LobbyLayoutService.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return LobbyLayoutService.userChangeGameScreenService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        LobbyLayoutService.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return LobbyLayoutService.userInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SocialNetworkNameUtils.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SocialNetworkNameUtils.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        Notification.display = IDisplay(param1);
      },function():IDisplay {
        return Notification.display;
      });
      osgi.injectService(INotificationSoundService,function(param1:Object):void {
        Notification.notificationSoundService = INotificationSoundService(param1);
      },function():INotificationSoundService {
        return Notification.notificationSoundService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        StageQualityService.display = IDisplay(param1);
      },function():IDisplay {
        return StageQualityService.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TimeUnitService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TimeUnitService.localeService;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new AlertModel());
      modelRegister.add(new BattleLinkActivatorModel());
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(IServerCaptcha,IServerCaptchaAdapt);
      modelRegisterAdapt.registerEvents(IServerCaptcha,IServerCaptchaEvents);
      modelRegister.add(new ServerCaptchaModel());
      modelRegister.add(new ChallengeTimeModel());
      modelRegister.add(new ColoringModel());
      modelRegisterAdapt.registerAdapt(IColoring,IColoringAdapt);
      modelRegisterAdapt.registerEvents(IColoring,IColoringEvents);
      modelRegisterAdapt.registerAdapt(Detach,DetachAdapt);
      modelRegisterAdapt.registerEvents(Detach,DetachEvents);
      modelRegister.add(new DetachModel());
      modelRegisterAdapt.registerAdapt(ExternalAuthApi,ExternalAuthApiAdapt);
      modelRegisterAdapt.registerEvents(ExternalAuthApi,ExternalAuthApiEvents);
      modelRegister.add(new ExternalAuthApiModel());
      modelRegister.add(new GPUDetectorModel());
      modelRegisterAdapt.registerAdapt(ILobbyLayout,ILobbyLayoutAdapt);
      modelRegisterAdapt.registerEvents(ILobbyLayout,ILobbyLayoutEvents);
      modelRegister.add(new LobbyLayoutModel());
      modelRegisterAdapt.registerAdapt(ILobbyLayoutNotify,ILobbyLayoutNotifyAdapt);
      modelRegisterAdapt.registerEvents(ILobbyLayoutNotify,ILobbyLayoutNotifyEvents);
      modelRegister.add(new LobbyLayoutNotifyModel());
      modelRegister.add(new MoveUserToServerModel());
      modelRegisterAdapt.registerAdapt(DataOwner,DataOwnerAdapt);
      modelRegisterAdapt.registerEvents(DataOwner,DataOwnerEvents);
      modelRegister.add(new DataOwnerModel());
      modelRegister.add(new ServerHaltModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
