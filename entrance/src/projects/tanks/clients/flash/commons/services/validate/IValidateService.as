package projects.tanks.clients.flash.commons.services.validate {
  public interface IValidateService {
    function isEmailValid(param1:String) : Boolean;
    function isValidPromoCode(param1:String) : Boolean;
    function isUidValid(param1:String) : Boolean;
    function isValidIdentificationStringForRegistration(param1:String) : Boolean;
    function isValidIdentificationStringForLogin(param1:String) : Boolean;
    function isChinaCardIdValid(param1:String) : Boolean;
    function isChinaNameValid(param1:String) : Boolean;
    function getForbiddenCharactersCountForRegistration(param1:String) : int;
    function getForbiddenLettersCountForRegistration(param1:String) : int;
  }
}
