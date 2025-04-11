package alternativa.tanks.gui.payment.forms.platbox {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.paymentstatus.PaymentStatusForm;
  import platform.client.fp10.core.type.IGameObject;

  public class PlatBoxForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    public static const WIDTH:int = 270;
    public static const HEIGHT:int = 70;

    private var phoneForm:PlatboxPhoneNumberForm;
    private var statusForm:PaymentStatusForm;

    public function PlatBoxForm(param1:IGameObject) {
      super(param1);
      this.phoneForm = new PlatboxPhoneNumberForm(param1);
      this.phoneForm.addEventListener(ProceedPaymentEvent.PROCEED,this.onProceed);
      addChild(this.phoneForm);
      this.statusForm = new PaymentStatusForm("Отправка СМС для подтверждения платежа");
      this.statusForm.visible = false;
      addChild(this.statusForm);
    }

    private function onProceed(param1:ProceedPaymentEvent) : void {
      logProceedAction();
    }

    public function showPaymentProgress() : void {
      this.phoneForm.visible = false;
      this.statusForm.visible = true;
      this.statusForm.showProgressWorking();
    }

    public function showPaymentInitialized() : void {
      this.statusForm.showProgressDone();
    }

    override public function activate() : void {
      this.phoneForm.visible = true;
      this.statusForm.visible = false;
      this.phoneForm.reset();
    }

    public function phoneNumber() : String {
      return this.phoneForm.phoneNumber;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function destroy() : void {
      super.destroy();
      this.phoneForm.removeEventListener(ProceedPaymentEvent.PROCEED,this.onProceed);
    }

    public function showPhoneIsInvalid(param1:String) : void {
      this.phoneForm.showPhoneIsInvalid(param1);
    }

    public function showPhoneIsValid(param1:String) : void {
      this.phoneForm.showPhoneIsValid(param1);
    }
  }
}
