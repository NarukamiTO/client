package alternativa.tanks.model.payment.modes.braintree {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BraintreePaymentEvents implements BraintreePayment {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BraintreePaymentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isPayPal() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:BraintreePayment = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BraintreePayment(this.impl[i]);
          result = Boolean(m.isPayPal());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
