package alternativa.tanks.controller.events.showform {
  import flash.display.Bitmap;
  import flash.events.Event;

  public class ShowPartnersFormEvent extends Event {
    public static const REGISTRATION_FORM:String = "ShowPartnersFormEvent.REGISTRATION_FORM";
    public static const LOGIN_FORM:String = "ShowPartnersFormEvent.LOGIN_FORM";

    private var _loginCaptchaEnabled:Boolean;
    private var _allowExternalLogin:Boolean;
    private var _backgroundImage:Bitmap;

    public function ShowPartnersFormEvent(param1:String, param2:Bitmap, param3:Boolean = true, param4:Boolean = false) {
      super(param1);
      this._backgroundImage = param2;
      this._allowExternalLogin = param3;
      this._loginCaptchaEnabled = param4;
    }

    public function get allowExternalLogin() : Boolean {
      return this._allowExternalLogin;
    }

    public function get backgroundImage() : Bitmap {
      return this._backgroundImage;
    }

    override public function clone() : Event {
      return new ShowPartnersFormEvent(this.type,this.backgroundImage,this.allowExternalLogin,this.loginCaptchaEnabled);
    }

    public function get loginCaptchaEnabled() : Boolean {
      return this._loginCaptchaEnabled;
    }
  }
}
