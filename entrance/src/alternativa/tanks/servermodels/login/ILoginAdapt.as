package alternativa.tanks.servermodels.login {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginAdapt implements ILogin {
    private var object:IGameObject;
    private var impl:ILogin;

    public function ILoginAdapt(param1:IGameObject, param2:ILogin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function login(param1:String, param2:String, param3:Boolean) : void {
      var uid:String = param1;
      var password:String = param2;
      var remember:Boolean = param3;
      try {
        Model.object = this.object;
        this.impl.login(uid,password,remember);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
