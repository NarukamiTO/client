package alternativa.tanks.model.useremailandpassword {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IUserEmailAndPasswordEvents implements IUserEmailAndPassword {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IUserEmailAndPasswordEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function changeEmail(param1:String) : void {
      var i:int = 0;
      var m:IUserEmailAndPassword = null;
      var email:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserEmailAndPassword(this.impl[i]);
          m.changeEmail(email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getEmail() : String {
      var result:String = null;
      var i:int = 0;
      var m:IUserEmailAndPassword = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserEmailAndPassword(this.impl[i]);
          result = m.getEmail();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function sendChangeInstruction() : void {
      var i:int = 0;
      var m:IUserEmailAndPassword = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserEmailAndPassword(this.impl[i]);
          m.sendChangeInstruction();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
