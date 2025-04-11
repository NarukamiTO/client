package alternativa.tanks.model.payment.modes.leogaming {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LeogamingPaymentModeEvents implements LeogamingPaymentMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function LeogamingPaymentModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendPhone(param1:String) : void {
      var i:int = 0;
      var m:LeogamingPaymentMode = null;
      var phone:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LeogamingPaymentMode(this.impl[i]);
          m.sendPhone(phone);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function sendCode(param1:String) : void {
      var i:int = 0;
      var m:LeogamingPaymentMode = null;
      var code:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LeogamingPaymentMode(this.impl[i]);
          m.sendCode(code);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
