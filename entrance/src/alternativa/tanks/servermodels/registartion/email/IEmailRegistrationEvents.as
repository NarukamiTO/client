package alternativa.tanks.servermodels.registartion.email {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEmailRegistrationEvents implements IEmailRegistration {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IEmailRegistrationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkEmail(param1:String) : void {
      var i:int = 0;
      var m:IEmailRegistration = null;
      var email:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEmailRegistration(this.impl[i]);
          m.checkEmail(email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function register(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      var i:int = 0;
      var m:IEmailRegistration = null;
      var uid:String = param1;
      var email:String = param2;
      var registeredUrl:String = param3;
      var referralHash:String = param4;
      var realName:String = param5;
      var idNumber:String = param6;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEmailRegistration(this.impl[i]);
          m.register(uid,email,registeredUrl,referralHash,realName,idNumber);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
