package alternativa.tanks.model.payment.modes.alipay {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.alipay.AlipayPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.alipay.IAlipayPaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInfo]
  public class AlipayPaymentModel extends AlipayPaymentModelBase implements IAlipayPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function AlipayPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      var local1:Long = paymentWindowService.getChosenItem().id;
      server.getPaymentUrl(local1);
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      PayUrl(object.adapt(PayUrl)).forceGoToUrl(param1);
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new GoToUrlForm(object));
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(PayModeForm);
    }
  }
}
