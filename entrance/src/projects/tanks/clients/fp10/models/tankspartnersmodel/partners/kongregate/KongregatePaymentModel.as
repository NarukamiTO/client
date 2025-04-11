package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.kongregate {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.partners.impl.kongregate.IKongregatePaymentModelBase;
  import projects.tanks.client.partners.impl.kongregate.KongregatePaymentModelBase;

  [ModelInfo]
  public class KongregatePaymentModel extends KongregatePaymentModelBase implements IKongregatePaymentModelBase, PayModeView, AsyncUrlPayMode, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function KongregatePaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      server.getPaymentTransaction(paymentWindowService.getChosenItem().id);
    }

    public function receivePaymentTransaction(param1:String) : void {
      KongregateInstanceWrapper.kongregate.mtx.purchaseItemsRemote(param1,this.onPurchaseResult);
      paymentWindowService.switchToBeginning();
    }

    private function onPurchaseResult(param1:Object) : void {
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new GoToUrlForm(object));
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(PayModeForm);
    }
  }
}
