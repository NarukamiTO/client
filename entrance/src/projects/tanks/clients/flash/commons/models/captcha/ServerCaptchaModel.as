package projects.tanks.clients.flash.commons.models.captcha {
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.client.commons.models.captcha.CaptchaModelBase;
  import projects.tanks.client.commons.models.captcha.ICaptchaModelBase;

  [ModelInfo]
  public class ServerCaptchaModel extends CaptchaModelBase implements ICaptchaModelBase, IServerCaptcha {
    private var clientFacade:CaptchaClientFacade;

    public function ServerCaptchaModel() {
      super();
    }

    public function showCaptcha(param1:CaptchaLocation, param2:Vector.<int>) : void {
      this.clientFacade.captchaUpdated(param1,param2);
    }

    public function captchaCorrect(param1:CaptchaLocation) : void {
      this.clientFacade.captchaAnswerCorrect(param1);
    }

    public function captchaFailed(param1:CaptchaLocation, param2:Vector.<int>) : void {
      this.clientFacade.captchaAnswerIncorrect(param1,param2);
    }

    public function checkCaptcha(param1:String, param2:CaptchaLocation) : void {
      server.checkCaptcha(param2,param1);
    }

    public function getNewCaptcha(param1:CaptchaLocation) : void {
      server.getNewCaptcha(param1);
    }

    public function bindFacade(param1:CaptchaClientFacade) : void {
      this.clientFacade = param1;
      param1.setCaptchaLocations(getInitParam().stateWithCaptcha);
    }

    public function unbindFacade() : void {
      this.clientFacade = null;
    }
  }
}
