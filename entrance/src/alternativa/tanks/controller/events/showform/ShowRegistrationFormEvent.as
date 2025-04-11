package alternativa.tanks.controller.events.showform {
  import flash.display.Bitmap;
  import flash.events.Event;

  public class ShowRegistrationFormEvent extends Event {
    public static const SHOW:String = "ShowRegistrationFormEvent.SHOW";

    private var _antiAddictionEnabled:Boolean;
    private var _captchaEnabled:Boolean;
    private var _skipRegistrationEnabled:Boolean;
    private var _goToLoginPageEnabled:Boolean;
    private var _backgroundImage:Bitmap;
    private var _registrationThroughEmail:Boolean;

    public function ShowRegistrationFormEvent(param1:Bitmap = null, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true, param5:Boolean = true, param6:Boolean = true) {
      super(SHOW);
      this._backgroundImage = param1;
      this._antiAddictionEnabled = param2;
      this._captchaEnabled = param3;
      this._skipRegistrationEnabled = param4;
      this._goToLoginPageEnabled = param5;
      this._registrationThroughEmail = param6;
    }

    public function get antiAddictionEnabled() : Boolean {
      return this._antiAddictionEnabled;
    }

    public function get captchaEnabled() : Boolean {
      return this._captchaEnabled;
    }

    public function get backgroundImage() : Bitmap {
      return this._backgroundImage;
    }

    public function get skipRegistrationEnabled() : Boolean {
      return this._skipRegistrationEnabled;
    }

    public function get goToLoginPageEnabled() : Boolean {
      return this._goToLoginPageEnabled;
    }

    public function get registrationThroughEmail() : Boolean {
      return this._registrationThroughEmail;
    }
  }
}
