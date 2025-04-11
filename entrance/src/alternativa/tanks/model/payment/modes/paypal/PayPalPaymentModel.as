package alternativa.tanks.model.payment.modes.paypal {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.WaitUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.paypal.IPayPalPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.paypal.PayPalPaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class PayPalPaymentModel extends PayPalPaymentModelBase implements IPayPalPaymentModelBase, ObjectLoadListener, AsyncUrlPayMode, PayModeView, PayModeProceed, ObjectUnloadListener, PayPalPayment {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private var url:PaymentRequestUrl;

    public function PayPalPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      var local1:Long = paymentWindowService.getChosenItem().id;
      server.getPaymentUrl(local1);
    }

    public function proceedPayment() : void {
      PayUrl(object.adapt(PayUrl)).forceGoToUrl(this.url);
    }

    public function receiveErrorUrl(param1:PaymentRequestUrl) : void {
      WaitUrlForm(this.getView()).onErrorUrlReceived();
    }

    public function receivePaymentUrl(param1:PaymentRequestUrl) : void {
      this.url = param1;
      WaitUrlForm(this.getView()).onPaymentUrlReceived();
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new WaitUrlForm(object));
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(PayModeForm);
    }
  }
}
