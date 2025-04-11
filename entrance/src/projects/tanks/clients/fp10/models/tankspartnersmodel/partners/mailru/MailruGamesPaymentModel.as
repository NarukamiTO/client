package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.mailru {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import flash.external.ExternalInterface;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.partners.impl.mailru.payment.IMailruGamesPaymentModelBase;
  import projects.tanks.client.partners.impl.mailru.payment.MailruGamesPaymentModelBase;

  [ModelInfo]
  public class MailruGamesPaymentModel extends MailruGamesPaymentModelBase implements IMailruGamesPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function MailruGamesPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      server.getPaymentTransaction(paymentWindowService.getChosenItem().id);
    }

    public function receivePaymentTransaction(param1:String, param2:Number, param3:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("showMailruPaymentForItem",param1,param2,param3);
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
