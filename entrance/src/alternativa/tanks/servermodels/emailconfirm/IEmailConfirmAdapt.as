package alternativa.tanks.servermodels.emailconfirm {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEmailConfirmAdapt implements IEmailConfirm {
    private var object:IGameObject;
    private var impl:IEmailConfirm;

    public function IEmailConfirmAdapt(param1:IGameObject, param2:IEmailConfirm) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startEmailConfirm(param1:String, param2:String) : void {
      var emailConfirmHash:String = param1;
      var email:String = param2;
      try {
        Model.object = this.object;
        this.impl.startEmailConfirm(emailConfirmHash,email);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
