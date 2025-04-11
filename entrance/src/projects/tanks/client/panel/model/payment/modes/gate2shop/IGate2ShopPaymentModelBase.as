package projects.tanks.client.panel.model.payment.modes.gate2shop {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IGate2ShopPaymentModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
    function showEmailIsBusy(param1:String) : void;
    function showEmailIsForbidden(param1:String) : void;
    function showEmailIsFree(param1:String) : void;
  }
}
