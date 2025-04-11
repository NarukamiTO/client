package alternativa.tanks.model.useremailandpassword {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PasswordServiceAdapt implements PasswordService {
    private var object:IGameObject;
    private var impl:PasswordService;

    public function PasswordServiceAdapt(param1:IGameObject, param2:PasswordService) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkIsPasswordSet(param1:Function) : void {
      var callback:Function = param1;
      try {
        Model.object = this.object;
        this.impl.checkIsPasswordSet(callback);
      }
      finally {
        Model.popObject();
      }
    }

    public function checkPassword(param1:String, param2:Function) : void {
      var password:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        this.impl.checkPassword(password,callback);
      }
      finally {
        Model.popObject();
      }
    }

    public function setPassword(param1:String) : void {
      var password:String = param1;
      try {
        Model.object = this.object;
        this.impl.setPassword(password);
      }
      finally {
        Model.popObject();
      }
    }

    public function updatePassword(param1:String, param2:String) : void {
      var oldPassword:String = param1;
      var newPassword:String = param2;
      try {
        Model.object = this.object;
        this.impl.updatePassword(oldPassword,newPassword);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
