package alternativa.tanks.model.payment.modes.onlyurl {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentMode;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.onlyurl.IOnlyUrlPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.onlyurl.OnlyUrlPaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInfo]
  public class OnlyUrlPaymentModel extends OnlyUrlPaymentModelBase implements IOnlyUrlPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener, OnlyUrlPayMode, CrystalsOnlyPaymentMode {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function OnlyUrlPaymentModel() {
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
