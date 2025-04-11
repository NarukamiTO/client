package alternativa.tanks.view.layers {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.view.StandAloneCaptchaForm;
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
  import alternativa.tanks.view.forms.primivites.Alert;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import forms.events.AlertEvent;
  import org.robotlegs.core.IInjector;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.ConfirmEmailStatus;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXScreen;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  public class EntranceView extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var timeUnitService:ITimeUnitService;

    [Inject]
    public static var registrationUXService:IRegistrationUXService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public var injector:IInjector;

    private var alert:Alert;
    private var _currentView:DisplayObject;
    private var _rememberCallsign:String = "";
    private var _rememberPassword:String = "";
    private var _rememberVerificationPassword:String = "";
    private var _emailText:String = "";

    public function EntranceView() {
      super();
    }

    public function showChangeUidAndPasswordForm() : void {
      var local1:Boolean = true;
      this.changeViewTo(new ChangeUidForm(local1));
    }

    public function showChangeUidForm() : void {
      var local1:Boolean = false;
      this.changeViewTo(new ChangeUidForm(local1));
    }

    public function showInviteForm() : void {
      this.changeViewTo(new InviteForm());
    }

    public function showLoginForm(param1:String, param2:Boolean, param3:Boolean, param4:String = null) : void {
      registrationUXService.logNavigationStart(RegistrationUXScreen.LOGIN);
      var local5:LoginForm = this.injector.instantiate(LoginForm);
      local5.callsign = param1;
      if(Boolean(param4)) {
        local5.password = param4;
      }
      local5.enableRegistration = param2;
      this.changeViewTo(local5);
      if(param3) {
        local5.showCaptchaSection();
      }
    }

    public function showAlertServerIsHalt() : void {
      this.removeAllForms();
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_SERVER_IS_RESTARTING_LOGIN_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function showAlertServerIsFrozen() : void {
      this.removeAllForms();
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_SERVER_FROZEN_ALERT_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function showExternalLoginForm(param1:String, param2:String, param3:Boolean) : void {
      var local4:LinkExternalLoginForm = this.injector.instantiate(LinkExternalLoginForm);
      local4.callsign = param2;
      local4.socialNetworkId = param1;
      this.changeViewTo(local4);
      if(param3) {
        local4.showCaptchaSection();
      }
      loaderWindowService.hideForcibly();
    }

    public function showExternalRegistrationForm(param1:String) : void {
      this.injector.mapValue(EntranceView,this);
      var local2:ExternalRegistrationForm = this.injector.instantiate(ExternalRegistrationForm);
      this.injector.injectInto(local2);
      this.changeViewTo(local2);
      this.injector.unmap(EntranceView);
      loaderWindowService.hideForcibly();
    }

    public function showRegistrationForm(param1:Bitmap, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void {
      registrationUXService.logNavigationStart(RegistrationUXScreen.MAIN);
      this.injector.mapValue(EntranceView,this);
      var local7:RegistrationForm = new RegistrationForm(param6,param2,param3,param1,param4,param5,this._rememberCallsign,this._rememberPassword,this._rememberVerificationPassword,this._emailText);
      this.injector.injectInto(local7);
      this.changeViewTo(local7);
      this.injector.unmap(EntranceView);
    }

    public function showChangeEmailAndPassword(param1:String) : void {
      var local2:ChangeEmailAndPasswordForm = this.injector.instantiate(ChangeEmailAndPasswordForm);
      local2.email = param1;
      this.changeViewTo(local2);
    }

    public function showRecoveryHashIsWrongAlert() : void {
      this.alert = new Alert();
      var local1:String = localeService.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_WRONG_LINK_TEXT);
      this.alert.showAlert(local1,Vector.<String>([AlertAnswer.OK]));
      this.changeViewTo(this.alert);
      this.alert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onWrongChangePasswordAlertButtonPressed);
    }

    private function onWrongChangePasswordAlertButtonPressed(param1:AlertEvent) : void {
      this.alert.removeEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onWrongChangePasswordAlertButtonPressed);
      this.showLoginForm("",true,false);
    }

    public function showRestorePasswordForm() : void {
      this.changeViewTo(this.injector.instantiate(PasswordRestoreForm));
    }

    public function showStandAloneCaptcha() : void {
      this.changeViewTo(this.injector.instantiate(StandAloneCaptchaForm));
    }

    public function showPartnersRegistrationForm(param1:Bitmap, param2:Boolean) : void {
      registrationUXService.logNavigationStart(RegistrationUXScreen.PARTNER);
      this.injector.mapValue(EntranceView,this);
      var local3:PartnersRegistrationForm = new PartnersRegistrationForm(param1,param2);
      this.injector.injectInto(local3);
      this.changeViewTo(local3);
      this.injector.unmap(EntranceView);
    }

    public function showPartnerLoginForm(param1:Bitmap, param2:Boolean) : void {
      registrationUXService.logNavigationStart(RegistrationUXScreen.LOGIN);
      this.injector.mapValue(EntranceView,this);
      var local3:LinkPartnerLoginForm = new LinkPartnerLoginForm(param1);
      this.injector.injectInto(local3);
      this.changeViewTo(local3);
      if(param2) {
        local3.showCaptchaSection();
      }
      this.injector.unmap(EntranceView);
    }

    private function changeViewTo(param1:DisplayObject) : void {
      var local2:RegistrationForm = null;
      if(Boolean(this._currentView)) {
        local2 = this._currentView as RegistrationForm;
        if(local2 != null) {
          this._rememberCallsign = local2.callsign;
          this._rememberPassword = local2.password;
          this._rememberVerificationPassword = local2.verificationPassword;
          this._emailText = local2.emailText;
        }
        removeChild(this._currentView);
      }
      this._currentView = param1;
      addChild(this._currentView);
    }

    public function removeAllForms() : void {
      while(numChildren > 0) {
        removeChildAt(0);
      }
    }

    public function get currentView() : DisplayObject {
      return this._currentView;
    }

    public function showConfirmEmailStatusAlert(param1:ConfirmEmailStatus) : void {
      this.alert = new Alert();
      switch(param1) {
        case ConfirmEmailStatus.ERROR:
          this.alert = new Alert(Alert.ERROR_CONFIRM_EMAIL);
          break;
        case ConfirmEmailStatus.OK:
          this.alert = new Alert(Alert.ALERT_CONFIRM_EMAIL);
          break;
        case ConfirmEmailStatus.OK_EXISTS:
          this.alert = new Alert(Alert.ALERT_CONFIRM_EMAIL);
      }
      this.alert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.goToLoginAfterAlertClosed);
      this.changeViewTo(this.alert);
    }

    public function showErrorWindow(param1:int) : void {
      addChild(new Alert(param1));
    }

    public function showBlockAlert(param1:String) : void {
      this.alert = new Alert();
      if(!partnerService.isRunningInsidePartnerEnvironment()) {
        this.alert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.goToLoginAfterAlertClosed);
        this.alert.showAlert(param1,Vector.<String>([AlertAnswer.OK]));
      } else {
        this.alert.showAlert(param1,Vector.<String>([]));
      }
      this.changeViewTo(this.alert);
      loaderWindowService.hideForcibly();
    }

    private function goToLoginAfterAlertClosed(param1:AlertEvent) : void {
      this.alert.removeEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.goToLoginAfterAlertClosed);
      this.showLoginForm("",true,false);
    }

    public function showKickAlert(param1:String, param2:int, param3:int, param4:int) : void {
      this.alert = new Alert();
      var local5:String = localeService.getText(TanksLocale.TEXT_YOU_WERE_KICKED_LOGIN_TEXT);
      local5 = local5.replace("{0}",param1);
      local5 = local5.replace("{1}",timeUnitService.getLocalizedTimeString(param2,param3,param4));
      if(!partnerService.isRunningInsidePartnerEnvironment()) {
        this.alert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.goToLoginAfterAlertClosed);
        this.alert.showAlert(local5,Vector.<String>([AlertAnswer.OK]));
      } else {
        this.alert.showAlert(local5,Vector.<String>([]));
      }
      this.changeViewTo(this.alert);
      loaderWindowService.hideForcibly();
    }
  }
}
