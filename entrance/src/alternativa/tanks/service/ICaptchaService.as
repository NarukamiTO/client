package alternativa.tanks.service {
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public interface ICaptchaService {
    function checkAnswer(param1:CaptchaLocation, param2:String, param3:Function) : void;
    function answerCorrect(param1:CaptchaLocation) : void;
    function setNewCaptchaBytes(param1:Vector.<int>, param2:CaptchaLocation) : void;
    function get loginCaptchaEnabled() : Boolean;
  }
}
