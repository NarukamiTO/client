package alternativa.tanks.model.payment.modes.braintree {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BraintreePaymentAdapt implements BraintreePayment {
    private var object:IGameObject;
    private var impl:BraintreePayment;

    public function BraintreePaymentAdapt(param1:IGameObject, param2:BraintreePayment) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isPayPal() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isPayPal());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
