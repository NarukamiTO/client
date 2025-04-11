package projects.tanks.client.commons.models.captcha {
  public class CaptchaLocation {
    public static const LOGIN_FORM:CaptchaLocation = new CaptchaLocation(0,"LOGIN_FORM");
    public static const REGISTER_FORM:CaptchaLocation = new CaptchaLocation(1,"REGISTER_FORM");
    public static const CLIENT_STARTUP:CaptchaLocation = new CaptchaLocation(2,"CLIENT_STARTUP");
    public static const RESTORE_PASSWORD_FORM:CaptchaLocation = new CaptchaLocation(3,"RESTORE_PASSWORD_FORM");
    public static const EMAIL_CHANGE_HASH:CaptchaLocation = new CaptchaLocation(4,"EMAIL_CHANGE_HASH");
    public static const ACCOUNT_SETTINGS_FORM:CaptchaLocation = new CaptchaLocation(5,"ACCOUNT_SETTINGS_FORM");

    private var _value:int;
    private var _name:String;

    public function CaptchaLocation(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<CaptchaLocation> {
      var local1:Vector.<CaptchaLocation> = new Vector.<CaptchaLocation>();
      local1.push(LOGIN_FORM);
      local1.push(REGISTER_FORM);
      local1.push(CLIENT_STARTUP);
      local1.push(RESTORE_PASSWORD_FORM);
      local1.push(EMAIL_CHANGE_HASH);
      local1.push(ACCOUNT_SETTINGS_FORM);
      return local1;
    }

    public function toString() : String {
      return "CaptchaLocation [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
