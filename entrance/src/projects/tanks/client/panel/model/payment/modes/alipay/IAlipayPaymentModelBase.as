package projects.tanks.client.panel.model.payment.modes.alipay {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IAlipayPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
