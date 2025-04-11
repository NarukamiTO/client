package projects.tanks.clients.fp10.models.tankspartnersmodel.china.china3rdplatform {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.WaitUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
  import projects.tanks.client.partners.impl.china.china3rdplatform.payment.China3rdPlatformPaymentModelBase;
  import projects.tanks.client.partners.impl.china.china3rdplatform.payment.IChina3rdPlatformPaymentModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class China3rdPlatformPaymentModel extends China3rdPlatformPaymentModelBase implements IChina3rdPlatformPaymentModelBase, AsyncUrlPayMode, PayModeProceed, ObjectLoadListener, PayModeView {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function China3rdPlatformPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      var local1:Long = paymentWindowService.getChosenItem().id;
      server.getPaymentUrl(local1);
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

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      putData(PaymentRequestUrl,param1);
      WaitUrlForm(this.getView()).onPaymentUrlReceived();
    }
  }
}
