package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.facebook {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;
  import flash.external.ExternalInterface;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.partners.impl.facebook.payment.FacebookPaymentModelBase;
  import projects.tanks.client.partners.impl.facebook.payment.IFacebookPaymentModelBase;

  [ModelInfo]
  public class FacebookPaymentModel extends FacebookPaymentModelBase implements IFacebookPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function FacebookPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      server.getPaymentTransaction(paymentWindowService.getChosenItem().id);
    }

    public function receivePaymentTransaction(param1:Long, param2:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("showFacebookPaymentForItem",param1.toString(),param2);
      }
      paymentWindowService.switchToBeginning();
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
