package projects.tanks.client.panel.model.payment.modes.braintree {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IBraintreePaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
