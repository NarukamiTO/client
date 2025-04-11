package alternativa.tanks.servermodels.registartion.email {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEmailRegistrationAdapt implements IEmailRegistration {
    private var object:IGameObject;
    private var impl:IEmailRegistration;

    public function IEmailRegistrationAdapt(param1:IGameObject, param2:IEmailRegistration) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkEmail(param1:String) : void {
      var email:String = param1;
      try {
        Model.object = this.object;
        this.impl.checkEmail(email);
      }
      finally {
        Model.popObject();
      }
    }

    public function register(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      var uid:String = param1;
      var email:String = param2;
      var registeredUrl:String = param3;
      var referralHash:String = param4;
      var realName:String = param5;
      var idNumber:String = param6;
      try {
        Model.object = this.object;
        this.impl.register(uid,email,registeredUrl,referralHash,realName,idNumber);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
