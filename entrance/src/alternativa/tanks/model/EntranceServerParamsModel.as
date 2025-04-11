package alternativa.tanks.model {
  import org.robotlegs.mvcs.Actor;

  public class EntranceServerParamsModel extends Actor {
    private var _inviteEnabled:Boolean;
    private var _serverHalt:Boolean;
    private var _serverFrozen:Boolean;
    private var _standAloneCaptchaEnabled:Boolean;
    private var _antiAddictionEnabled:Boolean;
    private var _registrationCaptchaEnabled:Boolean;
    private var _loginCaptchaEnabled:Boolean;
    private var _inGameRegistration:Boolean;
    private var _skipRegistrationEnabled:Boolean;
    private var _registrationThroughEmail:Boolean;

    public function EntranceServerParamsModel() {
      super();
    }

    public function get inviteEnabled() : Boolean {
      return this._inviteEnabled;
    }

    public function set inviteEnabled(param1:Boolean) : void {
      this._inviteEnabled = param1;
    }

    public function get serverHalt() : Boolean {
      return this._serverHalt;
    }

    public function set serverHalt(param1:Boolean) : void {
      this._serverHalt = param1;
    }

    public function get serverFrozen() : Boolean {
      return this._serverFrozen;
    }

    public function set serverFrozen(param1:Boolean) : void {
      this._serverFrozen = param1;
    }

    public function get standAloneCaptchaEnabled() : Boolean {
      return this._standAloneCaptchaEnabled;
    }

    public function set standAloneCaptchaEnabled(param1:Boolean) : void {
      this._standAloneCaptchaEnabled = param1;
    }

    public function get antiAddictionEnabled() : Boolean {
      return this._antiAddictionEnabled;
    }

    public function set antiAddictionEnabled(param1:Boolean) : void {
      this._antiAddictionEnabled = param1;
    }

    public function get registrationCaptchaEnabled() : Boolean {
      return this._registrationCaptchaEnabled;
    }

    public function set registrationCaptchaEnabled(param1:Boolean) : void {
      this._registrationCaptchaEnabled = param1;
    }

    public function get inGameRegistration() : Boolean {
      return this._inGameRegistration;
    }

    public function set inGameRegistration(param1:Boolean) : void {
      this._inGameRegistration = param1;
    }

    public function get loginCaptchaEnabled() : Boolean {
      return this._loginCaptchaEnabled;
    }

    public function set loginCaptchaEnabled(param1:Boolean) : void {
      this._loginCaptchaEnabled = param1;
    }

    public function get skipRegistrationEnabled() : Boolean {
      return this._skipRegistrationEnabled;
    }

    public function set skipRegistrationEnabled(param1:Boolean) : void {
      this._skipRegistrationEnabled = param1;
    }

    public function get registrationThroughEmail() : Boolean {
      return this._registrationThroughEmail;
    }

    public function set registrationThroughEmail(param1:Boolean) : void {
      this._registrationThroughEmail = param1;
    }
  }
}
