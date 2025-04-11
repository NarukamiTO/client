package alternativa.tanks.model.payment.modes.gate2shop {
  import alternativa.tanks.gui.EmailBlockRequestEvent;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.gate2shop.Gate2ShopForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.gate2shop.Gate2ShopPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.gate2shop.IGate2ShopPaymentModelBase;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  [ModelInfo]
  public class Gate2ShopPaymentModel extends Gate2ShopPaymentModelBase implements IGate2ShopPaymentModelBase, Gate2ShopPayment, AsyncUrlPayMode, ObjectLoadListener, PayModeView, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private var emailFormPassed:Boolean = false;

    public function Gate2ShopPaymentModel() {
      super();
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new Gate2ShopForm(object));
      this.view.addEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
    }

    public function requestAsyncUrl() : void {
      server.getPaymentUrl(paymentWindowService.getChosenItem().id);
    }

    public function registerEmailAndGetPaymentUrl(param1:String) : void {
      this.emailFormPassed = true;
      server.registerEmailAndGetPaymentUrl(paymentWindowService.getChosenItem().id,param1);
    }

    public function receiveUrl(param1:PaymentRequestUrl) : void {
      PayUrl(object.adapt(PayUrl)).forceGoToOrderedUrl(param1);
    }

    public function objectUnloaded() : void {
      this.view.removeEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
      this.view.destroy();
      clearData(PayModeForm);
    }

    public function getView() : PayModeForm {
      return PayModeForm(Gate2ShopForm(getData(PayModeForm)));
    }

    public function emailInputRequired() : Boolean {
      return getInitParam().emailInputRequired && !this.emailFormPassed;
    }

    private function onValidateEmail(param1:EmailBlockRequestEvent) : void {
      server.validateEmail(param1.email);
    }

    public function showEmailIsBusy(param1:String) : void {
      this.view.showEmailIsBusy(param1);
    }

    public function showEmailIsForbidden(param1:String) : void {
      this.view.showEmailIsForbidden(param1);
    }

    public function showEmailIsFree(param1:String) : void {
      this.view.showEmailIsFree(param1);
    }

    private function get view() : Gate2ShopForm {
      return Gate2ShopForm(getData(PayModeForm));
    }
  }
}
