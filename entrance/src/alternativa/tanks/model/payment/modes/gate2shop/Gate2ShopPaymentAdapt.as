package alternativa.tanks.model.payment.modes.gate2shop {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class Gate2ShopPaymentAdapt implements Gate2ShopPayment {
    private var object:IGameObject;
    private var impl:Gate2ShopPayment;

    public function Gate2ShopPaymentAdapt(param1:IGameObject, param2:Gate2ShopPayment) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function emailInputRequired() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.emailInputRequired());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function registerEmailAndGetPaymentUrl(param1:String) : void {
      var email:String = param1;
      try {
        Model.object = this.object;
        this.impl.registerEmailAndGetPaymentUrl(email);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
