package alternativa.tanks.servermodels.loginbyhash {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginByHashEvents implements ILoginByHash {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILoginByHashEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loginByHash(param1:String) : void {
      var i:int = 0;
      var m:ILoginByHash = null;
      var hash:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILoginByHash(this.impl[i]);
          m.loginByHash(hash);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function loginBySingleUseHash(param1:String) : void {
      var i:int = 0;
      var m:ILoginByHash = null;
      var hash:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILoginByHash(this.impl[i]);
          m.loginBySingleUseHash(hash);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
