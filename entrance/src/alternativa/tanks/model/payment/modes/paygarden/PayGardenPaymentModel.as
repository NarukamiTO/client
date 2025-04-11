package alternativa.tanks.model.payment.modes.paygarden {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.paygarden.IPayGardenPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInfo]
  public class PayGardenPaymentModel extends PayGardenPaymentModelBase implements IPayGardenPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener, PayGardenPayment {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function PayGardenPaymentModel() {
      super();
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      PayUrl(object.adapt(PayUrl)).forceGoToOrderedUrl(param1);
    }

    public function requestAsyncUrl() : void {
      var local1:Long = paymentWindowService.getChosenItem().id;
      server.getPaymentUrl(local1);
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

    public function getProductType() : PayGardenProductType {
      return getInitParam().productType;
    }
  }
}
