package alternativa.tanks.model.payment.modes.leogaming {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LeogamingPaymentModeAdapt implements LeogamingPaymentMode {
    private var object:IGameObject;
    private var impl:LeogamingPaymentMode;

    public function LeogamingPaymentModeAdapt(param1:IGameObject, param2:LeogamingPaymentMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendPhone(param1:String) : void {
      var phone:String = param1;
      try {
        Model.object = this.object;
        this.impl.sendPhone(phone);
      }
      finally {
        Model.popObject();
      }
    }

    public function sendCode(param1:String) : void {
      var code:String = param1;
      try {
        Model.object = this.object;
        this.impl.sendCode(code);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
