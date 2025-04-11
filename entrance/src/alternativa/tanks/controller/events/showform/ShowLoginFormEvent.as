package alternativa.tanks.controller.events.showform {
  import flash.events.Event;

  public class ShowLoginFormEvent extends Event {
    public static const SHOW:String = "ShowLoginFormEvent.SHOW";

    private var _uid:String;
    private var _registrationEnabled:Boolean;
    private var _loginCaptchaEnabled:Boolean;
    private var _password:String;

    public function ShowLoginFormEvent(param1:String, param2:Boolean, param3:Boolean, param4:String = null) {
      super(SHOW);
      this._uid = param1;
      this._registrationEnabled = param2;
      this._loginCaptchaEnabled = param3;
      this._password = param4;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function get registrationEnabled() : Boolean {
      return this._registrationEnabled;
    }

    public function get loginCaptchaEnabled() : Boolean {
      return this._loginCaptchaEnabled;
    }

    public function get password() : String {
      return this._password;
    }
  }
}
