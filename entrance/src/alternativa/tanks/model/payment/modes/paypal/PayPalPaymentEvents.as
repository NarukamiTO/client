package alternativa.tanks.model.payment.modes.paypal {
  import platform.client.fp10.core.type.IGameObject;

  public class PayPalPaymentEvents implements PayPalPayment {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayPalPaymentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
