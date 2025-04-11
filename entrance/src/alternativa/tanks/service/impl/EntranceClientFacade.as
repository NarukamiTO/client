package alternativa.tanks.service.impl {
  import alternativa.tanks.controller.events.AuthorizationFailedEvent;
  import alternativa.tanks.controller.events.CallsignCheckResultEvent;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.ChangeUidResultEvent;
  import alternativa.tanks.controller.events.EmailCheckResultEvent;
  import alternativa.tanks.controller.events.EntranceErrorEvent;
  import alternativa.tanks.controller.events.InviteCheckResultEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.ParseUrlParamsEvent;
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.controller.events.PasswordRestoreResultEvent;
  import alternativa.tanks.controller.events.RegistrationFailedEvent;
  import alternativa.tanks.controller.events.SetPasswordChangeResultEvent;
  import alternativa.tanks.controller.events.showform.ShowBlockValidationAlertEvent;
  import alternativa.tanks.controller.events.showform.ShowChangeEmailAndPasswordFormEvent;
  import alternativa.tanks.controller.events.showform.ShowConfirmEmailAlertEvent;
  import alternativa.tanks.controller.events.showform.ShowFormEvent;
  import alternativa.tanks.controller.events.showform.ShowLoginFormEvent;
  import alternativa.tanks.controller.events.socialnetwork.NavigationExternalEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.model.RegistrationBackgroundModel;
  import alternativa.tanks.service.ICaptchaService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.view.layers.EntranceViewEvent;
  import flash.display.BitmapData;
  import org.robotlegs.mvcs.Actor;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.ConfirmEmailStatus;

  public class EntranceClientFacade extends Actor implements IEntranceClientFacade {
    [Inject]
    public var registrationBackgroundModel:RegistrationBackgroundModel;

    [Inject]
    public var serverParams:EntranceServerParamsModel;

    [Inject]
    public var paramsModel:EntranceUrlParamsModel;

    [Inject]
    public var captchaService:ICaptchaService;

    public function EntranceClientFacade() {
      super();
    }

    public function set registrationFormBackgroundRGB(param1:BitmapData) : void {
      this.registrationBackgroundModel.rgbData = param1;
    }

    public function set entranceObject(param1:IGameObject) : void {
      dispatch(new ParseUrlParamsEvent());
    }

    public function wrongPassword() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.PASSWORD_AUTHORIZATION_FAILED));
    }

    public function wrongPasswordExternalEntrance() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.PASSWORD_EXTERNAL_AUTHORIZATION_FAILED));
    }

    public function externalLinkAlreadyExists() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.EXTERNAL_LINK_ALREADY_EXISTS));
    }

    public function externalValidationFailed() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.EXTERNAL_VALIDATION_FAILED));
    }

    public function inviteAlreadyActivated(param1:String) : void {
      dispatch(new ShowLoginFormEvent(param1,false,false));
    }

    public function inviteIsFree() : void {
      dispatch(new ShowLoginFormEvent("",true,false));
    }

    public function goToLoginForm() : void {
      dispatch(new NavigationEvent(NavigationEvent.GO_TO_LOGIN_FORM));
    }

    public function goToLoginFormWithHashError() : void {
      dispatch(new NavigationEvent(NavigationEvent.GO_TO_LOGIN_FORM));
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.HASH_AUTHORIZATION_FAILED));
    }

    public function goToExternalRegistrationForm(param1:String) : void {
      dispatch(new NavigationExternalEvent(NavigationExternalEvent.GO_TO_EXTERNAL_REGISTRATION_FORM,param1));
    }

    public function goToExternalLoginForm(param1:String) : void {
      dispatch(new NavigationExternalEvent(NavigationExternalEvent.GO_TO_EXTERNAL_LOGIN_FORM,param1));
    }

    public function callsignIsFree() : void {
      dispatch(new CallsignCheckResultEvent(CallsignCheckResultEvent.CALLSIGN_IS_FREE));
    }

    public function callsignIsBusy(param1:Vector.<String>) : void {
      var local2:CallsignCheckResultEvent = new CallsignCheckResultEvent(CallsignCheckResultEvent.CALLSIGN_IS_BUSY);
      local2.freeUids = param1;
      dispatch(local2);
    }

    public function callsignIsIncorrect() : void {
      dispatch(new CallsignCheckResultEvent(CallsignCheckResultEvent.CALLSIGN_IS_INCORRECT));
    }

    public function inviteNotFound() : void {
      dispatch(new InviteCheckResultEvent(InviteCheckResultEvent.INVITE_CODE_DOES_NOT_EXIST));
    }

    public function showView() : void {
      dispatch(new EntranceViewEvent(EntranceViewEvent.SHOW));
    }

    public function hideView() : void {
      dispatch(new EntranceViewEvent(EntranceViewEvent.HIDE));
    }

    public function set inviteEnabled(param1:Boolean) : void {
      this.serverParams.inviteEnabled = param1;
    }

    public function set registrationThroughEmail(param1:Boolean) : void {
      this.serverParams.registrationThroughEmail = param1;
    }

    public function emailWithRestoreLinkSuccessfullySent() : void {
      dispatch(new PasswordRestoreResultEvent(PasswordRestoreResultEvent.RESTORE_MESSAGE_HAVE_BEEN_SENT));
    }

    public function emailNotFound() : void {
      dispatch(new PasswordRestoreResultEvent(PasswordRestoreResultEvent.EMAIL_DOES_NOT_EXISTS));
    }

    public function goToChangePasswordAndEmailForm(param1:String) : void {
      dispatch(new ShowChangeEmailAndPasswordFormEvent(param1));
    }

    public function recoveryHashIsWrong() : void {
      dispatch(new ShowFormEvent(ShowFormEvent.SHOW_RECOVERY_HASH_IS_WRONG_ALERT));
    }

    public function captchaUpdated(param1:CaptchaLocation, param2:Vector.<int>) : void {
      this.captchaService.setNewCaptchaBytes(param2,param1);
    }

    public function set antiAddictionEnabled(param1:Boolean) : void {
      this.serverParams.antiAddictionEnabled = param1;
    }

    public function setCaptchaLocations(param1:Vector.<CaptchaLocation>) : void {
      this.serverParams.standAloneCaptchaEnabled = param1.indexOf(CaptchaLocation.CLIENT_STARTUP) != -1;
      this.serverParams.registrationCaptchaEnabled = param1.indexOf(CaptchaLocation.REGISTER_FORM) != -1;
      this.serverParams.loginCaptchaEnabled = param1.indexOf(CaptchaLocation.LOGIN_FORM) != -1;
    }

    public function setPasswordChangeResult(param1:Boolean, param2:String) : void {
      dispatch(new SetPasswordChangeResultEvent(param1,param2));
    }

    public function confirmEmailStatus(param1:ConfirmEmailStatus) : void {
      dispatch(new ShowConfirmEmailAlertEvent(param1));
    }

    public function blockValidationAlert(param1:String) : void {
      dispatch(new ShowBlockValidationAlertEvent(ShowBlockValidationAlertEvent.YOU_WERE_BLOCKED,param1));
    }

    public function kickValidationAlert(param1:String, param2:int, param3:int, param4:int) : void {
      dispatch(new ShowBlockValidationAlertEvent(ShowBlockValidationAlertEvent.YOU_WERE_KICKED,param1,param2,param3,param4));
    }

    public function captchaAnswerCorrect(param1:CaptchaLocation) : void {
      this.captchaService.answerCorrect(param1);
    }

    public function captchaAnswerIncorrect(param1:CaptchaLocation, param2:Vector.<int>) : void {
      dispatch(new CaptchaAnswerIsIncorrectEvent());
      this.captchaService.setNewCaptchaBytes(param2,param1);
    }

    public function startPartnerRegistration() : void {
      dispatch(new PartnersEvent(PartnersEvent.START_REGISTRATION));
    }

    public function partnerLinkAlreadyExists() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.PARTNER_LINK_ALREADY_EXISTS));
    }

    public function partnerWrongPassword() : void {
      dispatch(new AuthorizationFailedEvent(AuthorizationFailedEvent.PARTNER_PASSWORD_AUTHORIZATION_FAILED));
    }

    public function registrationPasswordIsIncorrect() : void {
      dispatch(new RegistrationFailedEvent(RegistrationFailedEvent.PASSWORD_IS_INCORRECT));
    }

    public function serverHalt() : void {
      if(!this.serverParams.serverHalt) {
        this.serverParams.serverHalt = true;
        dispatch(new EntranceErrorEvent(EntranceErrorEvent.SERVER_HALT));
      }
    }

    public function emailIsInvalid() : void {
      dispatch(new EmailCheckResultEvent(EmailCheckResultEvent.EMAIL_IS_INVALID));
    }

    public function emailIsBusy() : void {
      dispatch(new EmailCheckResultEvent(EmailCheckResultEvent.EMAIL_IS_BUSY));
    }

    public function emailIsFree() : void {
      dispatch(new EmailCheckResultEvent(EmailCheckResultEvent.EMAIL_IS_FREE));
    }

    public function emailDomainIsForbidden() : void {
      dispatch(new EmailCheckResultEvent(EmailCheckResultEvent.EMAIL_DOMAIN_IS_FORBIDDEN));
    }

    public function emailWithPasswordSuccessfullySent(param1:String) : void {
      this.paramsModel.passedCallsign = param1;
      this.goToLoginForm();
    }

    public function goToChangeUidAndPasswordForm() : void {
      dispatch(new ShowFormEvent(ShowFormEvent.SHOW_CHANGE_UID_AND_PASSWORD_FORM));
    }

    public function goToChangeUidForm() : void {
      dispatch(new ShowFormEvent(ShowFormEvent.SHOW_CHANGE_UID_FORM));
    }

    public function uidChangedSuccessfully(param1:String) : void {
      this.paramsModel.passedCallsign = param1;
      this.goToLoginForm();
    }

    public function changeUidFailedPasswordIsIncorrect() : void {
      dispatch(new ChangeUidResultEvent(ChangeUidResultEvent.PASSWORD_IS_INCORRECT));
    }
  }
}
