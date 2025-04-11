package alternativa.tanks.model.payment.modes.platbox {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberValidationEvent;
  import alternativa.tanks.gui.payment.forms.platbox.PlatBoxForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteEvent;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.platbox.IPlatBoxPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.platbox.PlatBoxPaymentModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  [ModelInfo]
  public class PlatBoxPaymentModel extends PlatBoxPaymentModelBase implements IPlatBoxPaymentModelBase, ObjectLoadListener, PayModeView, PayModeProceed, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    [Inject]
    public static var paymentCompleteService:PaymentCompleteService;

    public function PlatBoxPaymentModel() {
      super();
    }

    private static function onPaymentComplete(param1:PaymentCompleteEvent) : void {
      if(paymentWindowService.getChosenPayMode() == object) {
        paymentWindowService.switchToBeginning();
      }
    }

    public function objectLoaded() : void {
      putData(PayModeForm,new PlatBoxForm(object));
      this.view.addEventListener(PhoneNumberValidationEvent.VALIDATE,getFunctionWrapper(this.onPhoneValidation));
      paymentCompleteService.addEventListener(PaymentCompleteEvent.COMPLETED,getFunctionWrapper(onPaymentComplete));
    }

    public function objectUnloaded() : void {
      this.view.removeEventListener(PhoneNumberValidationEvent.VALIDATE,getFunctionWrapper(this.onPhoneValidation));
      paymentCompleteService.removeEventListener(PaymentCompleteEvent.COMPLETED,getFunctionWrapper(onPaymentComplete));
      this.view.destroy();
      clearData(PayModeForm);
    }

    public function getView() : PayModeForm {
      return PayModeForm(this.view);
    }

    public function paymentInited() : void {
      this.view.showPaymentInitialized();
    }

    public function proceedPayment() : void {
      server.initPayment(this.view.phoneNumber(),paymentWindowService.getChosenItem().id);
      this.view.showPaymentProgress();
    }

    private function onPhoneValidation(param1:PhoneNumberValidationEvent) : void {
      if(paymentWindowService.getChosenPayMode() == object) {
        server.checkNumber(param1.getPhoneNumber());
      }
    }

    public function phoneIsInvalid(param1:String) : void {
      this.view.showPhoneIsInvalid(param1);
    }

    public function phoneIsValid(param1:String) : void {
      this.view.showPhoneIsValid(param1);
    }

    private function get view() : PlatBoxForm {
      return PlatBoxForm(getData(PayModeForm));
    }

    public function paymentError() : void {
      this.view.activate();
    }
  }
}
