package alternativa.tanks.servermodels.emailandpasswordchanger {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IPasswordRecoveryEvents implements IPasswordRecovery {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IPasswordRecoveryEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startEmailAndPasswordChangeProcess(param1:String) : void {
      var i:int = 0;
      var m:IPasswordRecovery = null;
      var passwordChangeHash:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IPasswordRecovery(this.impl[i]);
          m.startEmailAndPasswordChangeProcess(passwordChangeHash);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function sendUsersRestorePasswordLink(param1:String) : void {
      var i:int = 0;
      var m:IPasswordRecovery = null;
      var email:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IPasswordRecovery(this.impl[i]);
          m.sendUsersRestorePasswordLink(email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function changePasswordAndEmail(param1:String, param2:String) : void {
      var i:int = 0;
      var m:IPasswordRecovery = null;
      var newPassword:String = param1;
      var newEmail:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IPasswordRecovery(this.impl[i]);
          m.changePasswordAndEmail(newPassword,newEmail);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
