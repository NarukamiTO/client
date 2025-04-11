package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class StartRegistration extends Event {
    public static const START_REGISTRATION:String = "START_REGISTRATION";

    private var _registrationCaptchaEnabled:Boolean;
    private var _antiAddictionEnabled:Boolean;

    public function StartRegistration(param1:Boolean, param2:Boolean) {
      super(START_REGISTRATION);
      this._registrationCaptchaEnabled = param1;
      this._antiAddictionEnabled = param2;
    }

    public function get registrationCaptchaEnabled() : Boolean {
      return this._registrationCaptchaEnabled;
    }

    public function get antiAddictionEnabled() : Boolean {
      return this._antiAddictionEnabled;
    }
  }
}
