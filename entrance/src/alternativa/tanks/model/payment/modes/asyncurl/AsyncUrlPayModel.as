package alternativa.tanks.model.payment.modes.asyncurl {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.WaitUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.asyncurl.AsyncUrlModelBase;
  import projects.tanks.client.panel.model.payment.modes.asyncurl.IAsyncUrlModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class AsyncUrlPayModel extends AsyncUrlModelBase implements IAsyncUrlModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, PayModeProceed, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function AsyncUrlPayModel() {
      super();
    }

    public function proceedPayment() : void {
      PayUrl(object.adapt(PayUrl)).forceGoToUrl(PaymentRequestUrl(getData(PaymentRequestUrl)));
      clearData(PaymentRequestUrl);
    }

    public function requestAsyncUrl() : void {
      server.getUrl(paymentWindowService.getChosenItem());
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      putData(PaymentRequestUrl,param1);
      WaitUrlForm(this.getView()).onPaymentUrlReceived();
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new WaitUrlForm(object));
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(PayModeForm);
    }

    public function showErrorUrlReceived() : void {
      WaitUrlForm(this.getView()).onErrorUrlReceived();
    }
  }
}
