package alternativa.tanks.servermodels.loginbyhash {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginByHashAdapt implements ILoginByHash {
    private var object:IGameObject;
    private var impl:ILoginByHash;

    public function ILoginByHashAdapt(param1:IGameObject, param2:ILoginByHash) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loginByHash(param1:String) : void {
      var hash:String = param1;
      try {
        Model.object = this.object;
        this.impl.loginByHash(hash);
      }
      finally {
        Model.popObject();
      }
    }

    public function loginBySingleUseHash(param1:String) : void {
      var hash:String = param1;
      try {
        Model.object = this.object;
        this.impl.loginBySingleUseHash(hash);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
