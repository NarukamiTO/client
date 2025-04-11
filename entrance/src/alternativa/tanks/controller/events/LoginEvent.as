package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class LoginEvent extends Event {
    public static const CHECK_CAPTCHA_AND_LOGIN:String = "LoginEvent.CHECK_CAPTCHA_AND_LOGIN";
    public static const LOGIN_AFTER_CAPTCHA_CHECKED:String = "LoginEvent.LOGIN_AFTER_CAPTCHA_CHECKED";

    private var _callsign:String;
    private var _password:String;
    private var _rememberMe:Boolean;
    private var _captchaAnswer:String;

    public function LoginEvent(param1:String, param2:String, param3:String, param4:Boolean, param5:String) {
      super(param1);
      this._callsign = param2;
      this._password = param3;
      this._rememberMe = param4;
      this._captchaAnswer = param5;
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

    public function get captchaAnswer() : String {
      return this._captchaAnswer;
    }
  }
}
