package alternativa.tanks.service {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public interface IEntranceServerFacade {
    function checkCallsign(param1:String) : void;
    function checkEmail(param1:String) : void;
    function checkInviteCode(param1:String) : void;
    function sendEmailRestoreMessage(param1:String) : void;
    function login(param1:String, param2:String, param3:Boolean) : void;
    function loginExternal(param1:String, param2:String) : void;
    function fightWithoutRegistration() : void;
    function checkEmailChangeHash(param1:String) : void;
    function changePasswordAndEmail(param1:String, param2:String) : void;
    function loginByHash(param1:String) : void;
    function loginBySingleUseHash(param1:String) : void;
    function confirmEmail(param1:String, param2:String) : void;
    function checkChangeUidHash(param1:String, param2:String) : void;
    function changeUidAndPassword(param1:String, param2:String) : void;
    function changeUid(param1:String) : void;
    function set entranceObject(param1:IGameObject) : void;
    function registerUserThroughPassword(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void;
    function registerThroughEmail(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;
    function getNewCaptcha(param1:CaptchaLocation) : void;
    function checkCaptcha(param1:String, param2:CaptchaLocation) : void;
    function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void;
    function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void;
    function finishExternalRegisterUser(param1:String, param2:String) : void;
    function loadPartnerObject(param1:String) : void;
    function finishPartnerRegistration(param1:String, param2:String) : void;
    function bindAccountToPartner(param1:String, param2:String) : void;
    function googleLogin(param1:String) : void;
  }
}
