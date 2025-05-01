package projects.tanks.clients.fp10.models.tanksusermodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.controller.commands.goto_.GoToPartnerRegistrationCommand;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import alternativa.tanks.servermodels.EntranceModel;
  import alternativa.tanks.servermodels.GoogleEntranceModel;
  import alternativa.tanks.servermodels.IEntrance;
  import alternativa.tanks.servermodels.IEntranceAdapt;
  import alternativa.tanks.servermodels.IEntranceEvents;
  import alternativa.tanks.servermodels.IGoogleEntranceModel;
  import alternativa.tanks.servermodels.IGoogleEntranceModelAdapt;
  import alternativa.tanks.servermodels.IGoogleEntranceModelEvents;
  import alternativa.tanks.servermodels.ILeavableEntranceState;
  import alternativa.tanks.servermodels.ILeavableEntranceStateAdapt;
  import alternativa.tanks.servermodels.ILeavableEntranceStateEvents;
  import alternativa.tanks.servermodels.TrackingPixelShowing;
  import alternativa.tanks.servermodels.blockvalidator.BlockValidatorModel;
  import alternativa.tanks.servermodels.changeuid.ChangeUidModel;
  import alternativa.tanks.servermodels.changeuid.IChangeUid;
  import alternativa.tanks.servermodels.changeuid.IChangeUidAdapt;
  import alternativa.tanks.servermodels.changeuid.IChangeUidEvents;
  import alternativa.tanks.servermodels.emailandpasswordchanger.IPasswordRecovery;
  import alternativa.tanks.servermodels.emailandpasswordchanger.IPasswordRecoveryAdapt;
  import alternativa.tanks.servermodels.emailandpasswordchanger.IPasswordRecoveryEvents;
  import alternativa.tanks.servermodels.emailandpasswordchanger.PasswordRestoreModel;
  import alternativa.tanks.servermodels.emailconfirm.EmailConfirmModel;
  import alternativa.tanks.servermodels.emailconfirm.IEmailConfirm;
  import alternativa.tanks.servermodels.emailconfirm.IEmailConfirmAdapt;
  import alternativa.tanks.servermodels.emailconfirm.IEmailConfirmEvents;
  import alternativa.tanks.servermodels.invite.IInvite;
  import alternativa.tanks.servermodels.invite.IInviteAdapt;
  import alternativa.tanks.servermodels.invite.IInviteEvents;
  import alternativa.tanks.servermodels.invite.InviteModel;
  import alternativa.tanks.servermodels.logging.RegistrationUXLoggerModel;
  import alternativa.tanks.servermodels.login.ILogin;
  import alternativa.tanks.servermodels.login.ILoginAdapt;
  import alternativa.tanks.servermodels.login.ILoginEvents;
  import alternativa.tanks.servermodels.login.LoginModel;
  import alternativa.tanks.servermodels.loginbyhash.ILoginByHash;
  import alternativa.tanks.servermodels.loginbyhash.ILoginByHashAdapt;
  import alternativa.tanks.servermodels.loginbyhash.ILoginByHashEvents;
  import alternativa.tanks.servermodels.loginbyhash.LoginByHashModel;
  import alternativa.tanks.servermodels.loginwithoutregistration.ILoginWithoutRegistration;
  import alternativa.tanks.servermodels.loginwithoutregistration.ILoginWithoutRegistrationAdapt;
  import alternativa.tanks.servermodels.loginwithoutregistration.ILoginWithoutRegistrationEvents;
  import alternativa.tanks.servermodels.loginwithoutregistration.LoginWithoutRegistrationModel;
  import alternativa.tanks.servermodels.newbie.NewbieRegistrationModel;
  import alternativa.tanks.servermodels.objectdetach.EntranceObjectDetachModel;
  import alternativa.tanks.servermodels.partners.CompositePartnerModel;
  import alternativa.tanks.servermodels.partners.ICompositePartnerModel;
  import alternativa.tanks.servermodels.partners.ICompositePartnerModelAdapt;
  import alternativa.tanks.servermodels.partners.ICompositePartnerModelEvents;
  import alternativa.tanks.servermodels.pushnotification.NotificationTokenModel;
  import alternativa.tanks.servermodels.redirect.WarRedirectModel;
  import alternativa.tanks.servermodels.registartion.email.EmailRegistrationModel;
  import alternativa.tanks.servermodels.registartion.email.IEmailRegistration;
  import alternativa.tanks.servermodels.registartion.email.IEmailRegistrationAdapt;
  import alternativa.tanks.servermodels.registartion.email.IEmailRegistrationEvents;
  import alternativa.tanks.servermodels.registartion.password.IPasswordRegistration;
  import alternativa.tanks.servermodels.registartion.password.IPasswordRegistrationAdapt;
  import alternativa.tanks.servermodels.registartion.password.IPasswordRegistrationEvents;
  import alternativa.tanks.servermodels.registartion.password.PasswordRegistrationModel;
  import alternativa.tanks.servermodels.serverhalt.ServerHaltEntranceModel;
  import alternativa.tanks.servermodels.socialnetwork.ExternalEntranceModel;
  import alternativa.tanks.servermodels.socialnetwork.IExternalEntranceModel;
  import alternativa.tanks.servermodels.socialnetwork.IExternalEntranceModelAdapt;
  import alternativa.tanks.servermodels.socialnetwork.IExternalEntranceModelEvents;
  import alternativa.tanks.servermodels.telegram.TelegramEntranceModel;
  import alternativa.tanks.servermodels.timezoneoffset.TimeZoneOffsetModel;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.service.IExternalEntranceService;
  import alternativa.tanks.service.IPasswordParamsService;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.EntranceViewMediator;
  import alternativa.tanks.view.LinkPartnerLoginFormMediator;
  import alternativa.tanks.view.LoginFormMediator;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.forms.ChangeEmailAndPasswordForm;
  import alternativa.tanks.view.forms.ChangeUidForm;
  import alternativa.tanks.view.forms.ExternalRegistrationForm;
  import alternativa.tanks.view.forms.InviteForm;
  import alternativa.tanks.view.forms.LinkExternalLoginForm;
  import alternativa.tanks.view.forms.LinkPartnerLoginForm;
  import alternativa.tanks.view.forms.LoginForm;
  import alternativa.tanks.view.forms.PartnersRegistrationForm;
  import alternativa.tanks.view.forms.PasswordRestoreForm;
  import alternativa.tanks.view.forms.RegistrationForm;
  import alternativa.tanks.view.forms.commons.AntiAddictionSection;
  import alternativa.tanks.view.forms.commons.ChangeUidInputField;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import alternativa.tanks.view.forms.freeuids.FreeUidsForm;
  import alternativa.tanks.view.layers.EntranceView;
  import alternativa.tanks.view.registration.ExternalEntranceForm;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.services.externalauth.ExternalAuthParamsService;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

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
      osgi.injectService(IPartnerService,function(param1:Object):void {
        GoToPartnerRegistrationCommand.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return GoToPartnerRegistrationCommand.partnerService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        EntranceModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return EntranceModel.clientFacade;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        EntranceModel.display = IDisplay(param1);
      },function():IDisplay {
        return EntranceModel.display;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        EntranceModel.loaderWindow = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return EntranceModel.loaderWindow;
      });
      osgi.injectService(IEntranceServerFacade,function(param1:Object):void {
        EntranceModel.serverFacade = IEntranceServerFacade(param1);
      },function():IEntranceServerFacade {
        return EntranceModel.serverFacade;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        TrackingPixelShowing.clientLog = IClientLog(param1);
      },function():IClientLog {
        return TrackingPixelShowing.clientLog;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        BlockValidatorModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return BlockValidatorModel.clientFacade;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BlockValidatorModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return BlockValidatorModel.storageService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        BlockValidatorModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return BlockValidatorModel.trackerService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ChangeUidModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return ChangeUidModel.alertService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        ChangeUidModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return ChangeUidModel.clientFacade;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChangeUidModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChangeUidModel.localeService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        PasswordRestoreModel.entranceClientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return PasswordRestoreModel.entranceClientFacade;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        EmailConfirmModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return EmailConfirmModel.clientFacade;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        InviteModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return InviteModel.clientFacade;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        RegistrationUXLoggerModel.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return RegistrationUXLoggerModel.registrationUXService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        LoginModel.entranceClientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return LoginModel.entranceClientFacade;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        LoginByHashModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return LoginByHashModel.clientFacade;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        LoginByHashModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return LoginByHashModel.launcherParams;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        LoginByHashModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return LoginByHashModel.storageService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        NewbieRegistrationModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return NewbieRegistrationModel.storageService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        EntranceObjectDetachModel.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return EntranceObjectDetachModel.loaderWindowService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        CompositePartnerModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return CompositePartnerModel.alertService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        CompositePartnerModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return CompositePartnerModel.clientFacade;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        CompositePartnerModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return CompositePartnerModel.launcherParams;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CompositePartnerModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CompositePartnerModel.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        CompositePartnerModel.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return CompositePartnerModel.partnerService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        EmailRegistrationModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return EmailRegistrationModel.alertService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        EmailRegistrationModel.facade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return EmailRegistrationModel.facade;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EmailRegistrationModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EmailRegistrationModel.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        PasswordRegistrationModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return PasswordRegistrationModel.alertService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        PasswordRegistrationModel.facade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return PasswordRegistrationModel.facade;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        PasswordRegistrationModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return PasswordRegistrationModel.launcherParams;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PasswordRegistrationModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PasswordRegistrationModel.localeService;
      });
      osgi.injectService(NewbieUserService,function(param1:Object):void {
        PasswordRegistrationModel.newbieUserService = NewbieUserService(param1);
      },function():NewbieUserService {
        return PasswordRegistrationModel.newbieUserService;
      });
      osgi.injectService(IPasswordParamsService,function(param1:Object):void {
        PasswordRegistrationModel.passwordParamsService = IPasswordParamsService(param1);
      },function():IPasswordParamsService {
        return PasswordRegistrationModel.passwordParamsService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        PasswordRegistrationModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return PasswordRegistrationModel.storageService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        PasswordRegistrationModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return PasswordRegistrationModel.trackerService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        PasswordRegistrationModel.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return PasswordRegistrationModel.ymService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        ServerHaltEntranceModel.facade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return ServerHaltEntranceModel.facade;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ExternalEntranceModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return ExternalEntranceModel.alertService;
      });
      osgi.injectService(IEntranceClientFacade,function(param1:Object):void {
        ExternalEntranceModel.clientFacade = IEntranceClientFacade(param1);
      },function():IEntranceClientFacade {
        return ExternalEntranceModel.clientFacade;
      });
      osgi.injectService(ExternalAuthParamsService,function(param1:Object):void {
        ExternalEntranceModel.externalAuthParamsService = ExternalAuthParamsService(param1);
      },function():ExternalAuthParamsService {
        return ExternalEntranceModel.externalAuthParamsService;
      });
      osgi.injectService(IExternalEntranceService,function(param1:Object):void {
        ExternalEntranceModel.externalEntranceService = IExternalEntranceService(param1);
      },function():IExternalEntranceService {
        return ExternalEntranceModel.externalEntranceService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ExternalEntranceModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ExternalEntranceModel.localeService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        ExternalEntranceModel.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return ExternalEntranceModel.ymService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        EntranceViewMediator.clientLog = IClientLog(param1);
      },function():IClientLog {
        return EntranceViewMediator.clientLog;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        EntranceViewMediator.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return EntranceViewMediator.ymService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        LinkPartnerLoginFormMediator.clientLog = IClientLog(param1);
      },function():IClientLog {
        return LinkPartnerLoginFormMediator.clientLog;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        LinkPartnerLoginFormMediator.log = LogService(param1);
      },function():LogService {
        return LinkPartnerLoginFormMediator.log;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        LoginFormMediator.clientLog = IClientLog(param1);
      },function():IClientLog {
        return LoginFormMediator.clientLog;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EntranceBubbleFactory.LocaleService = ILocaleService(param1);
      },function():ILocaleService {
        return EntranceBubbleFactory.LocaleService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        ChangeEmailAndPasswordForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return ChangeEmailAndPasswordForm.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChangeEmailAndPasswordForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChangeEmailAndPasswordForm.localeService;
      });
      osgi.injectService(IPasswordParamsService,function(param1:Object):void {
        ChangeEmailAndPasswordForm.passwordParamsService = IPasswordParamsService(param1);
      },function():IPasswordParamsService {
        return ChangeEmailAndPasswordForm.passwordParamsService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        ChangeEmailAndPasswordForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return ChangeEmailAndPasswordForm.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ChangeUidForm.display = IDisplay(param1);
      },function():IDisplay {
        return ChangeUidForm.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChangeUidForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChangeUidForm.localeService;
      });
      osgi.injectService(IPasswordParamsService,function(param1:Object):void {
        ChangeUidForm.passwordParamsService = IPasswordParamsService(param1);
      },function():IPasswordParamsService {
        return ChangeUidForm.passwordParamsService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ExternalRegistrationForm.display = IDisplay(param1);
      },function():IDisplay {
        return ExternalRegistrationForm.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        ExternalRegistrationForm.helperService = IHelpService(param1);
      },function():IHelpService {
        return ExternalRegistrationForm.helperService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ExternalRegistrationForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ExternalRegistrationForm.localeService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        ExternalRegistrationForm.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return ExternalRegistrationForm.registrationUXService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        ExternalRegistrationForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return ExternalRegistrationForm.validateService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        InviteForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return InviteForm.loaderWindowService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        InviteForm.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return InviteForm.modalLoaderService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        LinkExternalLoginForm.display = IDisplay(param1);
      },function():IDisplay {
        return LinkExternalLoginForm.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LinkExternalLoginForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LinkExternalLoginForm.localeService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        LinkExternalLoginForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return LinkExternalLoginForm.validateService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        LinkPartnerLoginForm.clientLog = IClientLog(param1);
      },function():IClientLog {
        return LinkPartnerLoginForm.clientLog;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        LinkPartnerLoginForm.display = IDisplay(param1);
      },function():IDisplay {
        return LinkPartnerLoginForm.display;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        LinkPartnerLoginForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return LinkPartnerLoginForm.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LinkPartnerLoginForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LinkPartnerLoginForm.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        LinkPartnerLoginForm.log = LogService(param1);
      },function():LogService {
        return LinkPartnerLoginForm.log;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        LinkPartnerLoginForm.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return LinkPartnerLoginForm.registrationUXService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        LinkPartnerLoginForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return LinkPartnerLoginForm.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        LoginForm.display = IDisplay(param1);
      },function():IDisplay {
        return LoginForm.display;
      });
      osgi.injectService(IExternalEntranceService,function(param1:Object):void {
        LoginForm.externalEntranceService = IExternalEntranceService(param1);
      },function():IExternalEntranceService {
        return LoginForm.externalEntranceService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        LoginForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return LoginForm.loaderWindowService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        LoginForm.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return LoginForm.registrationUXService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        LoginForm.storageService = IStorageService(param1);
      },function():IStorageService {
        return LoginForm.storageService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        LoginForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return LoginForm.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PartnersRegistrationForm.display = IDisplay(param1);
      },function():IDisplay {
        return PartnersRegistrationForm.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        PartnersRegistrationForm.helperService = IHelpService(param1);
      },function():IHelpService {
        return PartnersRegistrationForm.helperService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PartnersRegistrationForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PartnersRegistrationForm.localeService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        PartnersRegistrationForm.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return PartnersRegistrationForm.registrationUXService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        PartnersRegistrationForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return PartnersRegistrationForm.validateService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        PasswordRestoreForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return PasswordRestoreForm.loaderWindowService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        PasswordRestoreForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return PasswordRestoreForm.validateService;
      });
      osgi.injectService(IExternalEntranceService,function(param1:Object):void {
        RegistrationForm.externalEntranceService = IExternalEntranceService(param1);
      },function():IExternalEntranceService {
        return RegistrationForm.externalEntranceService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        RegistrationForm.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return RegistrationForm.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RegistrationForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RegistrationForm.localeService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        RegistrationForm.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return RegistrationForm.registrationUXService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        RegistrationForm.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return RegistrationForm.ymService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        AntiAddictionSection.validateService = IValidateService(param1);
      },function():IValidateService {
        return AntiAddictionSection.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ChangeUidInputField.display = IDisplay(param1);
      },function():IDisplay {
        return ChangeUidInputField.display;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        ChangeUidInputField.validateService = IValidateService(param1);
      },function():IValidateService {
        return ChangeUidInputField.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        RegistrationCommonElementsSection.display = IDisplay(param1);
      },function():IDisplay {
        return RegistrationCommonElementsSection.display;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        RegistrationCommonElementsSection.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return RegistrationCommonElementsSection.launcherParams;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RegistrationCommonElementsSection.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RegistrationCommonElementsSection.localeService;
      });
      osgi.injectService(IPasswordParamsService,function(param1:Object):void {
        RegistrationCommonElementsSection.passwordParamsService = IPasswordParamsService(param1);
      },function():IPasswordParamsService {
        return RegistrationCommonElementsSection.passwordParamsService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        RegistrationCommonElementsSection.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return RegistrationCommonElementsSection.registrationUXService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        RegistrationCommonElementsSection.validateService = IValidateService(param1);
      },function():IValidateService {
        return RegistrationCommonElementsSection.validateService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        RegistrationCommonElementsSection.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return RegistrationCommonElementsSection.ymService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FreeUidsForm.display = IDisplay(param1);
      },function():IDisplay {
        return FreeUidsForm.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FreeUidsForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FreeUidsForm.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        EntranceView.alertService = IAlertService(param1);
      },function():IAlertService {
        return EntranceView.alertService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        EntranceView.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return EntranceView.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EntranceView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EntranceView.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        EntranceView.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return EntranceView.partnerService;
      });
      osgi.injectService(IRegistrationUXService,function(param1:Object):void {
        EntranceView.registrationUXService = IRegistrationUXService(param1);
      },function():IRegistrationUXService {
        return EntranceView.registrationUXService;
      });
      osgi.injectService(ITimeUnitService,function(param1:Object):void {
        EntranceView.timeUnitService = ITimeUnitService(param1);
      },function():ITimeUnitService {
        return EntranceView.timeUnitService;
      });
      osgi.injectService(IExternalEntranceService,function(param1:Object):void {
        ExternalEntranceForm.externalEntranceService = IExternalEntranceService(param1);
      },function():IExternalEntranceService {
        return ExternalEntranceForm.externalEntranceService;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new EntranceModel());
      modelRegister.add(new GoogleEntranceModel());
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(IEntrance,IEntranceAdapt);
      modelRegisterAdapt.registerEvents(IEntrance,IEntranceEvents);
      modelRegisterAdapt.registerAdapt(IGoogleEntranceModel,IGoogleEntranceModelAdapt);
      modelRegisterAdapt.registerEvents(IGoogleEntranceModel,IGoogleEntranceModelEvents);
      modelRegisterAdapt.registerAdapt(ILeavableEntranceState,ILeavableEntranceStateAdapt);
      modelRegisterAdapt.registerEvents(ILeavableEntranceState,ILeavableEntranceStateEvents);
      modelRegister.add(new TrackingPixelShowing());
      modelRegister.add(new BlockValidatorModel());
      modelRegister.add(new ChangeUidModel());
      modelRegisterAdapt.registerAdapt(IChangeUid,IChangeUidAdapt);
      modelRegisterAdapt.registerEvents(IChangeUid,IChangeUidEvents);
      modelRegisterAdapt.registerAdapt(IPasswordRecovery,IPasswordRecoveryAdapt);
      modelRegisterAdapt.registerEvents(IPasswordRecovery,IPasswordRecoveryEvents);
      modelRegister.add(new PasswordRestoreModel());
      modelRegister.add(new EmailConfirmModel());
      modelRegisterAdapt.registerAdapt(IEmailConfirm,IEmailConfirmAdapt);
      modelRegisterAdapt.registerEvents(IEmailConfirm,IEmailConfirmEvents);
      modelRegisterAdapt.registerAdapt(IInvite,IInviteAdapt);
      modelRegisterAdapt.registerEvents(IInvite,IInviteEvents);
      modelRegister.add(new InviteModel());
      modelRegister.add(new RegistrationUXLoggerModel());
      modelRegisterAdapt.registerAdapt(ILogin,ILoginAdapt);
      modelRegisterAdapt.registerEvents(ILogin,ILoginEvents);
      modelRegister.add(new LoginModel());
      modelRegisterAdapt.registerAdapt(ILoginByHash,ILoginByHashAdapt);
      modelRegisterAdapt.registerEvents(ILoginByHash,ILoginByHashEvents);
      modelRegister.add(new LoginByHashModel());
      modelRegisterAdapt.registerAdapt(ILoginWithoutRegistration,ILoginWithoutRegistrationAdapt);
      modelRegisterAdapt.registerEvents(ILoginWithoutRegistration,ILoginWithoutRegistrationEvents);
      modelRegister.add(new LoginWithoutRegistrationModel());
      modelRegister.add(new NewbieRegistrationModel());
      modelRegister.add(new EntranceObjectDetachModel());
      modelRegister.add(new CompositePartnerModel());
      modelRegisterAdapt.registerAdapt(ICompositePartnerModel,ICompositePartnerModelAdapt);
      modelRegisterAdapt.registerEvents(ICompositePartnerModel,ICompositePartnerModelEvents);
      modelRegister.add(new NotificationTokenModel());
      modelRegister.add(new WarRedirectModel());
      modelRegister.add(new EmailRegistrationModel());
      modelRegisterAdapt.registerAdapt(IEmailRegistration,IEmailRegistrationAdapt);
      modelRegisterAdapt.registerEvents(IEmailRegistration,IEmailRegistrationEvents);
      modelRegisterAdapt.registerAdapt(IPasswordRegistration,IPasswordRegistrationAdapt);
      modelRegisterAdapt.registerEvents(IPasswordRegistration,IPasswordRegistrationEvents);
      modelRegister.add(new PasswordRegistrationModel());
      modelRegister.add(new ServerHaltEntranceModel());
      modelRegister.add(new ExternalEntranceModel());
      modelRegisterAdapt.registerAdapt(IExternalEntranceModel,IExternalEntranceModelAdapt);
      modelRegisterAdapt.registerEvents(IExternalEntranceModel,IExternalEntranceModelEvents);
      modelRegister.add(new TelegramEntranceModel());
      modelRegister.add(new TimeZoneOffsetModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
