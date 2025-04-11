package alternativa.tanks.servermodels.login {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginEvents implements ILogin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILoginEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function login(param1:String, param2:String, param3:Boolean) : void {
      var i:int = 0;
      var m:ILogin = null;
      var uid:String = param1;
      var password:String = param2;
      var remember:Boolean = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILogin(this.impl[i]);
          m.login(uid,password,remember);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
