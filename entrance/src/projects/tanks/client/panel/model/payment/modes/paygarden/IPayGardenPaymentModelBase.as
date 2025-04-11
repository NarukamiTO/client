package projects.tanks.client.panel.model.payment.modes.paygarden {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IPayGardenPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
