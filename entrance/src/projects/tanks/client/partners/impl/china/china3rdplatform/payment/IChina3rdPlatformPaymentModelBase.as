package projects.tanks.client.partners.impl.china.china3rdplatform.payment {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IChina3rdPlatformPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
  }
}
