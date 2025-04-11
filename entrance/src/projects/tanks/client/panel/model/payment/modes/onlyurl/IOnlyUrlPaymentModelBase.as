package projects.tanks.client.panel.model.payment.modes.onlyurl {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IOnlyUrlPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
