package projects.tanks.client.panel.model.payment.modes.asyncurl {
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IAsyncUrlModelBase {
    function receiveUrl(param1:PaymentRequestUrl) : void;
    function showErrorUrlReceived() : void;
  }
}
