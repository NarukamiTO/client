package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class ChangeEmailCaptchaEvent extends Event {
    public static const CAPTCHA:String = "ChangeEmailCaptchaEvent.CAPTCHA";

    private var captchaAnswer:String;
    private var password:String;
    private var email:String;

    public function ChangeEmailCaptchaEvent(param1:String, param2:String, param3:String) {
      super(CAPTCHA);
      this.captchaAnswer = param1;
      this.password = param2;
      this.email = param3;
    }

    public function getCaptchaAnswer() : String {
      return this.captchaAnswer;
    }

    public function getPassword() : String {
      return this.password;
    }

    public function getEmail() : String {
      return this.email;
    }
  }
}
