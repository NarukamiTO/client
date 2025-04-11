package alternativa.tanks.servermodels.socialnetwork {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IExternalEntranceModelAdapt implements IExternalEntranceModel {
    private var object:IGameObject;
    private var impl:IExternalEntranceModel;

    public function IExternalEntranceModelAdapt(param1:IGameObject, param2:IExternalEntranceModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void {
      var socialNetworkId:String = param1;
      var rememberMe:Boolean = param2;
      var domain:String = param3;
      try {
        Model.object = this.object;
        this.impl.startExternalRegisterUser(socialNetworkId,rememberMe,domain);
      }
      finally {
        Model.popObject();
      }
    }

    public function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void {
      var socialNetworkId:String = param1;
      var rememberMe:Boolean = param2;
      var domain:String = param3;
      try {
        Model.object = this.object;
        this.impl.startExternalLoginUser(socialNetworkId,rememberMe,domain);
      }
      finally {
        Model.popObject();
      }
    }

    public function finishExternalRegisterUser(param1:String, param2:String) : void {
      var uid:String = param1;
      var referralHash:String = param2;
      try {
        Model.object = this.object;
        this.impl.finishExternalRegisterUser(uid,referralHash);
      }
      finally {
        Model.popObject();
      }
    }

    public function login(param1:String, param2:String) : void {
      var uid:String = param1;
      var password:String = param2;
      try {
        Model.object = this.object;
        this.impl.login(uid,password);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
