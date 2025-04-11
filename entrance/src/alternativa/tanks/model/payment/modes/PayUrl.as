package alternativa.tanks.model.payment.modes {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInterface]
  public interface PayUrl {
    function forceGoToUrl(param1:PaymentRequestUrl) : void;
    function forceGoToOrderedUrl(param1:PaymentRequestUrl) : void;
  }
}
