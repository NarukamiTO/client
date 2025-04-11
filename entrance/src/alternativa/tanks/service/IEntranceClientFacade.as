package alternativa.tanks.service {
  import flash.display.BitmapData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.ConfirmEmailStatus;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaClientFacade;

  public interface IEntranceClientFacade extends CaptchaClientFacade {
    function set registrationFormBackgroundRGB(param1:BitmapData) : void;
    function set entranceObject(param1:IGameObject) : void;
    function wrongPassword() : void;
    function wrongPasswordExternalEntrance() : void;
    function inviteNotFound() : void;
    function inviteIsFree() : void;
    function inviteAlreadyActivated(param1:String) : void;
    function goToLoginForm() : void;
    function goToLoginFormWithHashError() : void;
    function callsignIsFree() : void;
    function callsignIsBusy(param1:Vector.<String>) : void;
    function callsignIsIncorrect() : void;
    function emailWithRestoreLinkSuccessfullySent() : void;
    function emailNotFound() : void;
    function recoveryHashIsWrong() : void;
    function goToChangePasswordAndEmailForm(param1:String) : void;
    function setPasswordChangeResult(param1:Boolean, param2:String) : void;
    function showView() : void;
    function hideView() : void;
    function set inviteEnabled(param1:Boolean) : void;
    function set registrationThroughEmail(param1:Boolean) : void;
    function set antiAddictionEnabled(param1:Boolean) : void;
    function confirmEmailStatus(param1:ConfirmEmailStatus) : void;
    function blockValidationAlert(param1:String) : void;
    function kickValidationAlert(param1:String, param2:int, param3:int, param4:int) : void;
    function startPartnerRegistration() : void;
    function partnerLinkAlreadyExists() : void;
    function partnerWrongPassword() : void;
    function registrationPasswordIsIncorrect() : void;
    function goToExternalRegistrationForm(param1:String) : void;
    function goToExternalLoginForm(param1:String) : void;
    function serverHalt() : void;
    function emailIsInvalid() : void;
    function emailIsBusy() : void;
    function emailIsFree() : void;
    function emailDomainIsForbidden() : void;
    function emailWithPasswordSuccessfullySent(param1:String) : void;
    function externalLinkAlreadyExists() : void;
    function externalValidationFailed() : void;
    function goToChangeUidAndPasswordForm() : void;
    function goToChangeUidForm() : void;
    function uidChangedSuccessfully(param1:String) : void;
    function changeUidFailedPasswordIsIncorrect() : void;
  }
}
