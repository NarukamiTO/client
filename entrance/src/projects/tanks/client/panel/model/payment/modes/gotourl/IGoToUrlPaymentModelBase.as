package projects.tanks.client.panel.model.payment.modes.gotourl {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IGoToUrlPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
