package alternativa.tanks.model.payment.modes.paypal {
  import platform.client.fp10.core.type.IGameObject;

  public class PayPalPaymentAdapt implements PayPalPayment {
    private var object:IGameObject;
    private var impl:PayPalPayment;

    public function PayPalPaymentAdapt(param1:IGameObject, param2:PayPalPayment) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
