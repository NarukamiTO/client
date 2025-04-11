package projects.tanks.clients.flash.commons.models.captcha {
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  [ModelInterface]
  public interface IServerCaptcha {
    function bindFacade(param1:CaptchaClientFacade) : void;
    function unbindFacade() : void;
    function checkCaptcha(param1:String, param2:CaptchaLocation) : void;
    function getNewCaptcha(param1:CaptchaLocation) : void;
  }
}
