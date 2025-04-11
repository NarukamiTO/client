package alternativa.tanks.controller.events.socialnetwork {
  import flash.events.Event;

  public class ExternalLoginEvent extends Event {
    public static const CHECK_CAPTCHA_AND_LOGIN:String = "ExternalLoginEvent.CHECK_CAPTCHA_AND_LOGIN";
    public static const LOGIN_AFTER_CAPTCHA_CHECKED:String = "ExternalLoginEvent.LOGIN_AFTER_CAPTCHA_CHECKED";

    private var _callsign:String;
    private var _password:String;
    private var _captchaAnswer:String;

    public function ExternalLoginEvent(param1:String, param2:String, param3:String, param4:String) {
      super(param1);
      this._callsign = param2;
      this._password = param3;
      this._captchaAnswer = param4;
    }

    public function get callsign() : String {
      return this._callsign;
    }

    public function get password() : String {
      return this._password;
    }

    public function get captchaAnswer() : String {
      return this._captchaAnswer;
    }

    override public function clone() : Event {
      return new ExternalLoginEvent(type,this.callsign,this.password,this.captchaAnswer);
    }
  }
}
