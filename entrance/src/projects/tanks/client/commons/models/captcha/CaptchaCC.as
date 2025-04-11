package projects.tanks.client.commons.models.captcha {
  public class CaptchaCC {
    private var _stateWithCaptcha:Vector.<CaptchaLocation>;

    public function CaptchaCC(param1:Vector.<CaptchaLocation> = null) {
      super();
      this._stateWithCaptcha = param1;
    }

    public function get stateWithCaptcha() : Vector.<CaptchaLocation> {
      return this._stateWithCaptcha;
    }

    public function set stateWithCaptcha(param1:Vector.<CaptchaLocation>) : void {
      this._stateWithCaptcha = param1;
    }

    public function toString() : String {
      var local1:String = "CaptchaCC [";
      local1 += "stateWithCaptcha = " + this.stateWithCaptcha + " ";
      return local1 + "]";
    }
  }
}
