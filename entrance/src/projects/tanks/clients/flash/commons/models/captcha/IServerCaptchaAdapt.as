package projects.tanks.clients.flash.commons.models.captcha {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class IServerCaptchaAdapt implements IServerCaptcha {
    private var object:IGameObject;
    private var impl:IServerCaptcha;

    public function IServerCaptchaAdapt(param1:IGameObject, param2:IServerCaptcha) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function bindFacade(param1:CaptchaClientFacade) : void {
      var captchaFacade:CaptchaClientFacade = param1;
      try {
        Model.object = this.object;
        this.impl.bindFacade(captchaFacade);
      }
      finally {
        Model.popObject();
      }
    }

    public function unbindFacade() : void {
      try {
        Model.object = this.object;
        this.impl.unbindFacade();
      }
      finally {
        Model.popObject();
      }
    }

    public function checkCaptcha(param1:String, param2:CaptchaLocation) : void {
      var answer:String = param1;
      var location:CaptchaLocation = param2;
      try {
        Model.object = this.object;
        this.impl.checkCaptcha(answer,location);
      }
      finally {
        Model.popObject();
      }
    }

    public function getNewCaptcha(param1:CaptchaLocation) : void {
      var location:CaptchaLocation = param1;
      try {
        Model.object = this.object;
        this.impl.getNewCaptcha(location);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
