package alternativa.tanks.model.useremailandpassword {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IUserEmailAndPasswordAdapt implements IUserEmailAndPassword {
    private var object:IGameObject;
    private var impl:IUserEmailAndPassword;

    public function IUserEmailAndPasswordAdapt(param1:IGameObject, param2:IUserEmailAndPassword) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function changeEmail(param1:String) : void {
      var email:String = param1;
      try {
        Model.object = this.object;
        this.impl.changeEmail(email);
      }
      finally {
        Model.popObject();
      }
    }

    public function getEmail() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getEmail();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function sendChangeInstruction() : void {
      try {
        Model.object = this.object;
        this.impl.sendChangeInstruction();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
