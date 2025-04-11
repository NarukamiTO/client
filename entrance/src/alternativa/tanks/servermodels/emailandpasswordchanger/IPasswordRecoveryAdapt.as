package alternativa.tanks.servermodels.emailandpasswordchanger {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IPasswordRecoveryAdapt implements IPasswordRecovery {
    private var object:IGameObject;
    private var impl:IPasswordRecovery;

    public function IPasswordRecoveryAdapt(param1:IGameObject, param2:IPasswordRecovery) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startEmailAndPasswordChangeProcess(param1:String) : void {
      var passwordChangeHash:String = param1;
      try {
        Model.object = this.object;
        this.impl.startEmailAndPasswordChangeProcess(passwordChangeHash);
      }
      finally {
        Model.popObject();
      }
    }

    public function sendUsersRestorePasswordLink(param1:String) : void {
      var email:String = param1;
      try {
        Model.object = this.object;
        this.impl.sendUsersRestorePasswordLink(email);
      }
      finally {
        Model.popObject();
      }
    }

    public function changePasswordAndEmail(param1:String, param2:String) : void {
      var newPassword:String = param1;
      var newEmail:String = param2;
      try {
        Model.object = this.object;
        this.impl.changePasswordAndEmail(newPassword,newEmail);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
