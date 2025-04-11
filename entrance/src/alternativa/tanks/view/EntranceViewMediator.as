package alternativa.tanks.view {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.EntranceErrorEvent;
  import alternativa.tanks.controller.events.showform.ShowBlockValidationAlertEvent;
  import alternativa.tanks.controller.events.showform.ShowChangeEmailAndPasswordFormEvent;
  import alternativa.tanks.controller.events.showform.ShowConfirmEmailAlertEvent;
  import alternativa.tanks.controller.events.showform.ShowExternalEntranceFormEvent;
  import alternativa.tanks.controller.events.showform.ShowFormEvent;
  import alternativa.tanks.controller.events.showform.ShowLoginFormEvent;
  import alternativa.tanks.controller.events.showform.ShowPartnersFormEvent;
  import alternativa.tanks.controller.events.showform.ShowRegistrationFormEvent;
  import alternativa.tanks.view.forms.primivites.Alert;
  import alternativa.tanks.view.layers.EntranceView;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class EntranceViewMediator extends Mediator {
    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var ymService:YandexMetricaService;

    private static const REGISTRATION_LOAD_FINISH:String = "RegistrationLoad:finish";

    [Inject]
    public var layer:EntranceView;

    [Inject]
    public var injector:IInjector;

    public function EntranceViewMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.layer);
      addContextListener(ShowRegistrationFormEvent.SHOW,this.onShowRegistrationForm,ShowRegistrationFormEvent);
      addContextListener(ShowChangeEmailAndPasswordFormEvent.SHOW,this.onShowChangeEmailAndPassword,ShowChangeEmailAndPasswordFormEvent);
      addContextListener(ShowLoginFormEvent.SHOW,this.onShowLoginForm,ShowLoginFormEvent);
      addContextListener(ShowConfirmEmailAlertEvent.SHOW,this.onShowConfirmEmailStatusAlert,ShowConfirmEmailAlertEvent);
      addContextListener(CaptchaAnswerIsIncorrectEvent.EVENT_TYPE,this.onCaptchaFailed);
      addContextListener(ShowFormEvent.SHOW_RESTORE_PASSWORD_FORM,this.onShowRestorePasswordForm,ShowFormEvent);
      addContextListener(ShowFormEvent.SHOW_INVITE_FORM,this.onShowInviteForm,ShowFormEvent);
      addContextListener(ShowFormEvent.SHOW_STAND_ALONE_CAPTCHA,this.onShowStandAloneCaptcha,ShowFormEvent);
      addContextListener(ShowFormEvent.SHOW_RECOVERY_HASH_IS_WRONG_ALERT,this.onShowRecoveryHashIsWrongAlert,ShowFormEvent);
      addContextListener(ShowPartnersFormEvent.REGISTRATION_FORM,this.onShowPartnersRegistration,ShowPartnersFormEvent);
      addContextListener(ShowPartnersFormEvent.LOGIN_FORM,this.onShowPartnersLogin,ShowPartnersFormEvent);
      addContextListener(ShowBlockValidationAlertEvent.YOU_WERE_KICKED,this.onShowKickAlert,ShowBlockValidationAlertEvent);
      addContextListener(ShowBlockValidationAlertEvent.YOU_WERE_BLOCKED,this.onShowBlockAlert,ShowBlockValidationAlertEvent);
      addContextListener(ShowExternalEntranceFormEvent.REGISTRATION_FORM,this.onShowExternalRegistrationForm,ShowExternalEntranceFormEvent);
      addContextListener(ShowExternalEntranceFormEvent.LOGIN_FORM,this.onShowExternalLoginForm,ShowExternalEntranceFormEvent);
      addContextListener(ShowFormEvent.SHOW_CHANGE_UID_AND_PASSWORD_FORM,this.onShowChangeUidAndPasswordForm,ShowFormEvent);
      addContextListener(ShowFormEvent.SHOW_CHANGE_UID_FORM,this.onShowChangeUidForm,ShowFormEvent);
      addContextListener(EntranceErrorEvent.SERVER_FROZEN,this.onServerFrozen);
      addContextListener(EntranceErrorEvent.SERVER_HALT,this.onServerHalt);
    }

    private function onServerFrozen(param1:EntranceErrorEvent) : void {
      this.layer.showAlertServerIsFrozen();
    }

    private function onServerHalt(param1:EntranceErrorEvent) : void {
      this.layer.showAlertServerIsHalt();
    }

    private function onShowBlockAlert(param1:ShowBlockValidationAlertEvent) : void {
      this.layer.showBlockAlert(param1.reason);
    }

    private function onShowKickAlert(param1:ShowBlockValidationAlertEvent) : void {
      this.layer.showKickAlert(param1.reason,param1.minutes,param1.hours,param1.days);
    }

    private function onCaptchaFailed(param1:CaptchaAnswerIsIncorrectEvent) : void {
      this.layer.showErrorWindow(Alert.CAPTCHA_INCORRECT);
    }

    private function onShowChangeEmailAndPassword(param1:ShowChangeEmailAndPasswordFormEvent) : void {
      this.layer.showChangeEmailAndPassword(param1.email);
    }

    private function onShowRegistrationForm(param1:ShowRegistrationFormEvent) : void {
      ymService.reachGoalIfPlayerWasInTutorial(REGISTRATION_LOAD_FINISH);
      this.layer.showRegistrationForm(param1.backgroundImage,param1.captchaEnabled,param1.antiAddictionEnabled,param1.skipRegistrationEnabled,param1.goToLoginPageEnabled,param1.registrationThroughEmail);
    }

    private function onShowLoginForm(param1:ShowLoginFormEvent) : void {
      this.layer.showLoginForm(param1.uid,param1.registrationEnabled,param1.loginCaptchaEnabled,param1.password);
    }

    private function onShowConfirmEmailStatusAlert(param1:ShowConfirmEmailAlertEvent) : void {
      this.layer.showConfirmEmailStatusAlert(param1.status);
    }

    private function onShowStandAloneCaptcha(param1:ShowFormEvent) : void {
      this.layer.showStandAloneCaptcha();
    }

    private function onShowInviteForm(param1:ShowFormEvent) : void {
      this.layer.showInviteForm();
    }

    private function onShowPartnersRegistration(param1:ShowPartnersFormEvent) : void {
      ymService.reachGoalIfPlayerWasInTutorial(REGISTRATION_LOAD_FINISH);
      this.layer.showPartnersRegistrationForm(param1.backgroundImage,param1.allowExternalLogin);
    }

    private function onShowPartnersLogin(param1:ShowPartnersFormEvent) : void {
      this.layer.showPartnerLoginForm(param1.backgroundImage,param1.loginCaptchaEnabled);
    }

    private function onShowRestorePasswordForm(param1:ShowFormEvent) : void {
      this.layer.showRestorePasswordForm();
    }

    private function onShowRecoveryHashIsWrongAlert(param1:ShowFormEvent) : void {
      this.layer.showRecoveryHashIsWrongAlert();
    }

    private function onShowExternalRegistrationForm(param1:ShowExternalEntranceFormEvent) : void {
      ymService.reachGoalIfPlayerWasInTutorial(REGISTRATION_LOAD_FINISH);
      this.layer.showExternalRegistrationForm(param1.socialNetworkId);
    }

    private function onShowExternalLoginForm(param1:ShowExternalEntranceFormEvent) : void {
      this.layer.showExternalLoginForm(param1.socialNetworkId,param1.presetCallsign,param1.loginCaptchaEnabled);
    }

    private function onShowChangeUidAndPasswordForm(param1:ShowFormEvent) : void {
      this.layer.showChangeUidAndPasswordForm();
    }

    private function onShowChangeUidForm(param1:ShowFormEvent) : void {
      this.layer.showChangeUidForm();
    }
  }
}
