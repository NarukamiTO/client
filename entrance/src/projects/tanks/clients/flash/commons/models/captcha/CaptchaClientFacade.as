package projects.tanks.clients.flash.commons.models.captcha {
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public interface CaptchaClientFacade {
    function captchaUpdated(param1:CaptchaLocation, param2:Vector.<int>) : void;
    function setCaptchaLocations(param1:Vector.<CaptchaLocation>) : void;
    function captchaAnswerCorrect(param1:CaptchaLocation) : void;
    function captchaAnswerIncorrect(param1:CaptchaLocation, param2:Vector.<int>) : void;
  }
}
