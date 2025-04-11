package projects.tanks.client.commons.models.captcha {
  public interface ICaptchaModelBase {
    function captchaCorrect(param1:CaptchaLocation) : void;
    function captchaFailed(param1:CaptchaLocation, param2:Vector.<int>) : void;
    function showCaptcha(param1:CaptchaLocation, param2:Vector.<int>) : void;
  }
}
