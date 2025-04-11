package alternativa.tanks.model.useremailandpassword {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PasswordServiceEvents implements PasswordService {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PasswordServiceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkIsPasswordSet(param1:Function) : void {
      var i:int = 0;
      var m:PasswordService = null;
      var callback:Function = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PasswordService(this.impl[i]);
          m.checkIsPasswordSet(callback);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function checkPassword(param1:String, param2:Function) : void {
      var i:int = 0;
      var m:PasswordService = null;
      var password:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PasswordService(this.impl[i]);
          m.checkPassword(password,callback);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setPassword(param1:String) : void {
      var i:int = 0;
      var m:PasswordService = null;
      var password:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PasswordService(this.impl[i]);
          m.setPassword(password);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function updatePassword(param1:String, param2:String) : void {
      var i:int = 0;
      var m:PasswordService = null;
      var oldPassword:String = param1;
      var newPassword:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PasswordService(this.impl[i]);
          m.updatePassword(oldPassword,newPassword);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
