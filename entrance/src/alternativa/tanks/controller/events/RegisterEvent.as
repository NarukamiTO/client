package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class RegisterEvent extends Event {
    public static const REGISTER_AFTER_CAPTCHA_CHECKED:String = "RegisterEvent.REGISTER_AFTER_CAPTCHA_CHECKED";
    public static const CHECK_CAPTCHA_AND_REGISTER:String = "RegisterEvent.CHECK_CAPTCHA_AND_REGISTER";

    private var _callsign:String;
    private var _email:String;
    private var _password:String;
    private var _rememberMe:Boolean;
    private var _realName:String;
    private var _idNumber:String;
    private var _captchaAnswer:String;

    public function RegisterEvent(param1:String, param2:String, param3:String, param4:String, param5:Boolean, param6:String, param7:String, param8:String) {
      super(param1);
      this._callsign = param2;
      this._email = param3;
      this._password = param4;
      this._rememberMe = param5;
      this._realName = param6;
      this._idNumber = param7;
      this._captchaAnswer = param8;
    }

    public function get callsign() : String {
      return this._callsign;
    }

    public function get password() : String {
      return this._password;
    }

    public function get rememberMe() : Boolean {
      return this._rememberMe;
    }

    public function get realName() : String {
      return this._realName;
    }

    public function get idNumber() : String {
      return this._idNumber;
    }

    public function get captchaAnswer() : String {
      return this._captchaAnswer;
    }

    public function get email() : String {
      return this._email;
    }
  }
}
