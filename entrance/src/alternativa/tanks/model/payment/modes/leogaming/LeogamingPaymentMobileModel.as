package alternativa.tanks.model.payment.modes.leogaming {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.leogaming.LeogamingMobileForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteEvent;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.leogaming.mobile.ILeogamingPaymentMobileModelBase;
  import projects.tanks.client.panel.model.payment.modes.leogaming.mobile.LeogamingPaymentMobileModelBase;

  [ModelInfo]
  public class LeogamingPaymentMobileModel extends LeogamingPaymentMobileModelBase implements ILeogamingPaymentMobileModelBase, ObjectLoadListener, PayModeView, ObjectUnloadListener, LeogamingPaymentMode {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    [Inject]
    public static var paymentCompleteService:PaymentCompleteService;

    public function LeogamingPaymentMobileModel() {
      super();
    }

    public function error() : void {
      LeogamingMobileForm(this.getFormInternal()).reset();
    }

    public function proceed() : void {
      LeogamingMobileForm(this.getFormInternal()).proceed();
    }

    public function objectLoaded() : void {
      putData(LeogamingMobileForm,new LeogamingMobileForm(object));
      paymentCompleteService.addEventListener(PaymentCompleteEvent.COMPLETED,getFunctionWrapper(this.onPaymentComplete));
    }

    private function onPaymentComplete(param1:PaymentCompleteEvent) : void {
      if(paymentWindowService.getChosenPayMode() == object) {
        paymentWindowService.switchToBeginning();
      }
    }

    public function getView() : PayModeForm {
      var local1:LeogamingMobileForm = this.getFormInternal();
      local1.reset();
      return local1;
    }

    private function getFormInternal() : LeogamingMobileForm {
      return LeogamingMobileForm(getData(LeogamingMobileForm));
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(LeogamingMobileForm);
      paymentCompleteService.removeEventListener(PaymentCompleteEvent.COMPLETED,getFunctionWrapper(this.onPaymentComplete));
    }

    public function sendPhone(param1:String) : void {
      server.createOrder(paymentWindowService.getChosenItem(),param1);
    }

    public function sendCode(param1:String) : void {
      server.confirmOrder(param1);
    }
  }
}
