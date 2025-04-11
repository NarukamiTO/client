package projects.tanks.client.panel.model.payment.modes.qiwi {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IQiwiPaymentModelBase {
    function error() : void;
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
