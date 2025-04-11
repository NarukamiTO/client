package projects.tanks.clients.flash.commons.services.validate {
  public class ValidateService implements IValidateService {
    public static const EMAIL_PATTERN:RegExp = /^[a-zA-Z0-9]([\-\_\.]?[a-zA-Z0-9\*]+)*@[a-zA-Z0-9]([\-\_\.]?[a-zA-Z0-9*]+)*\.[a-zA-Z]{2,}$/i;
    public static const PLAIN_UID_PATTERN:String = "[a-z0-9](([\\.\\-\\w](?!(-|_|\\.){2,}))*[a-z0-9])?";
    public static const PROMO_CODE_PATTERN:String = "[a-z0-9A-Z]";
    public static const UID_PATTERN:RegExp = new RegExp("^" + PLAIN_UID_PATTERN + "$","i");
    public static const NOT_ALLOWED_PATTERN_FOR_REGISTRATION:RegExp = /[^0-9a-zA-Z\.\-\_]/gi;
    public static const NOT_ALLOWED_PATTERN_FOR_LOGIN:RegExp = /[^0-9a-zA-Z@\.\-\_]/gi;
    public static const INVALID_LETTERS_PATTERN:RegExp = /[Ѐ-ӿ]+/;

    private static const CHINA_NAME_PATTERN:RegExp = /^[一-龥]+$/;

    public function ValidateService() {
      super();
    }

    public function isUidValid(param1:String) : Boolean {
      return param1.search(UID_PATTERN) != -1;
    }

    public function isEmailValid(param1:String) : Boolean {
      return param1.search(EMAIL_PATTERN) != -1;
    }

    public function isValidIdentificationStringForRegistration(param1:String) : Boolean {
      return param1.search(NOT_ALLOWED_PATTERN_FOR_REGISTRATION) == -1;
    }

    public function isValidIdentificationStringForLogin(param1:String) : Boolean {
      return param1.search(NOT_ALLOWED_PATTERN_FOR_LOGIN) == -1;
    }

    public function isValidPromoCode(param1:String) : Boolean {
      return param1.search(PROMO_CODE_PATTERN) == 0;
    }

    public function isChinaCardIdValid(param1:String) : Boolean {
      return ChinaCardIdValidator.isValidIdNumber(param1);
    }

    public function isChinaNameValid(param1:String) : Boolean {
      return param1.search(CHINA_NAME_PATTERN) != -1;
    }

    public function getForbiddenCharactersCountForRegistration(param1:String) : int {
      var local2:Array = param1.match(NOT_ALLOWED_PATTERN_FOR_REGISTRATION);
      if(local2 != null) {
        return local2.join().length;
      }
      return 0;
    }

    public function getForbiddenLettersCountForRegistration(param1:String) : int {
      var local3:Array = null;
      var local2:Array = param1.match(NOT_ALLOWED_PATTERN_FOR_REGISTRATION);
      if(local2 != null && (local3 = local2.join().match(INVALID_LETTERS_PATTERN)) != null) {
        return local3.join().length;
      }
      return 0;
    }
  }
}
