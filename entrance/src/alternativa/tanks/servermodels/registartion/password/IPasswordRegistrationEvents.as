package alternativa.tanks.servermodels.registartion.password {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IPasswordRegistrationEvents implements IPasswordRegistration {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IPasswordRegistrationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void {
      var i:int = 0;
      var m:IPasswordRegistration = null;
      var uid:String = param1;
      var password:String = param2;
      var registeredUrl:String = param3;
      var rememberMe:Boolean = param4;
      var referralHash:String = param5;
      var realName:String = param6;
      var idNumber:String = param7;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IPasswordRegistration(this.impl[i]);
          m.register(uid,password,registeredUrl,rememberMe,referralHash,realName,idNumber);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function checkCallsign(param1:String) : void {
      var i:int = 0;
      var m:IPasswordRegistration = null;
      var callsign:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IPasswordRegistration(this.impl[i]);
          m.checkCallsign(callsign);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
