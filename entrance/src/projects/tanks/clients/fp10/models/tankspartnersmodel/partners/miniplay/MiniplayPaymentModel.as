package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniplay {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import flash.external.ExternalInterface;
  import mx.utils.StringUtil;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.partners.impl.miniplay.IMiniplayPaymentModelBase;
  import projects.tanks.client.partners.impl.miniplay.MiniplayPaymentModelBase;

  [ModelInfo]
  public class MiniplayPaymentModel extends MiniplayPaymentModelBase implements IMiniplayPaymentModelBase, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    public function MiniplayPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      server.getPaymentData(paymentWindowService.getChosenItem().id);
    }

    public function receivePaymentData(param1:int, param2:String, param3:String, param4:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("showMiniplayPayment",StringUtil.substitute("{0}|{1}||{2}|{3}",param1,param2,param3,param4));
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
