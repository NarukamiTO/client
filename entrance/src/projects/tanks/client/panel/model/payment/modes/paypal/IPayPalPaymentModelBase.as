package projects.tanks.client.panel.model.payment.modes.paypal {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IPayPalPaymentModelBase {
    function receiveErrorUrl(param1:PaymentRequestUrl) : void;
    function receivePaymentUrl(param1:PaymentRequestUrl) : void;
  }
}
