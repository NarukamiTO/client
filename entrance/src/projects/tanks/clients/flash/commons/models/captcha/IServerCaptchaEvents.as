package projects.tanks.clients.flash.commons.models.captcha {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class IServerCaptchaEvents implements IServerCaptcha {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IServerCaptchaEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function bindFacade(param1:CaptchaClientFacade) : void {
      var i:int = 0;
      var m:IServerCaptcha = null;
      var captchaFacade:CaptchaClientFacade = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IServerCaptcha(this.impl[i]);
          m.bindFacade(captchaFacade);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unbindFacade() : void {
      var i:int = 0;
      var m:IServerCaptcha = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IServerCaptcha(this.impl[i]);
          m.unbindFacade();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function checkCaptcha(param1:String, param2:CaptchaLocation) : void {
      var i:int = 0;
      var m:IServerCaptcha = null;
      var answer:String = param1;
      var location:CaptchaLocation = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IServerCaptcha(this.impl[i]);
          m.checkCaptcha(answer,location);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getNewCaptcha(param1:CaptchaLocation) : void {
      var i:int = 0;
      var m:IServerCaptcha = null;
      var location:CaptchaLocation = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IServerCaptcha(this.impl[i]);
          m.getNewCaptcha(location);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
