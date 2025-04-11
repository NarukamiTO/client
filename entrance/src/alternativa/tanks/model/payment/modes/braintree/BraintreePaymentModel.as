package alternativa.tanks.model.payment.modes.braintree {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.WaitUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.braintree.BraintreePaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.braintree.IBraintreePaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class BraintreePaymentModel extends BraintreePaymentModelBase implements IBraintreePaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeProceed, PayModeView, ObjectUnloadListener, BraintreePayment {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function BraintreePaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      var local1:Long = paymentWindowService.getChosenItem().id;
      server.getPaymentUrl(local1);
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      putData(PaymentRequestUrl,param1);
      WaitUrlForm(this.getView()).onPaymentUrlReceived();
    }

    public function proceedPayment() : void {
      PayUrl(object.adapt(PayUrl)).forceGoToUrl(PaymentRequestUrl(getData(PaymentRequestUrl)));
      clearData(PaymentRequestUrl);
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

    public function isPayPal() : Boolean {
      return getInitParam().payPal;
    }
  }
}
