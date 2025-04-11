package alternativa.tanks.gui.payment.forms.leogaming {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.paymentstatus.PaymentStatusForm;
  import alternativa.tanks.model.payment.modes.leogaming.LeogamingPaymentMode;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LeogamingMobileForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const MARGIN:int = 20;

    private var phoneForm:LeogamingPhoneForm;
    private var codeConfirmForm:LeogamingCodeConfirmForm;
    private var proceedButton:ProceedButton;
    private var statusForm:PaymentStatusForm;
    private var state:LeogamingPhonePaymentState = LeogamingPhonePaymentState.PHONE;

    public function LeogamingMobileForm(param1:IGameObject) {
      super(param1);
      this.addPhoneForm();
      this.addCodeConfirmCode();
      this.addProceedButton();
      this.addStatus();
      this.render();
      this.setEvents();
    }

    private function addStatus() : void {
      this.statusForm = new PaymentStatusForm("Waiting for payment");
      this.statusForm.showProgressWorking();
      this.statusForm.visible = false;
      addChild(this.statusForm);
    }

    public function setPhoneForm() : void {
      this.phoneForm.visible = true;
      this.codeConfirmForm.visible = false;
      this.statusForm.visible = false;
      this.state = LeogamingPhonePaymentState.PHONE;
      this.render();
    }

    public function setCodeConfirmForm() : void {
      this.phoneForm.visible = false;
      this.codeConfirmForm.visible = true;
      this.codeConfirmForm.clear();
      this.proceedButton.visible = false;
      this.state = LeogamingPhonePaymentState.CONFIRM;
      this.render();
    }

    public function setWaitingPayment() : void {
      this.phoneForm.visible = false;
      this.codeConfirmForm.visible = false;
      this.proceedButton.visible = false;
      this.statusForm.visible = true;
      this.state = LeogamingPhonePaymentState.WAIT;
    }

    private function addPhoneForm() : void {
      this.phoneForm = new LeogamingPhoneForm();
      this.phoneForm.visible = true;
      addChild(this.phoneForm);
    }

    private function addCodeConfirmCode() : void {
      this.codeConfirmForm = new LeogamingCodeConfirmForm();
      this.codeConfirmForm.visible = false;
      addChild(this.codeConfirmForm);
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.visible = false;
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      addChild(this.proceedButton);
    }

    private function setEvents() : void {
      this.phoneForm.addEventListener(ValidationEvent.VALID,this.onValid);
      this.phoneForm.addEventListener(ValidationEvent.INVALID,this.onInvalid);
      this.codeConfirmForm.addEventListener(ValidationEvent.VALID,this.onValid);
      this.codeConfirmForm.addEventListener(ValidationEvent.INVALID,this.onInvalid);
      this.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClicked);
    }

    private function onProceedClicked(param1:Event) : void {
      var local2:String = null;
      if(this.state == LeogamingPhonePaymentState.PHONE) {
        payMode.adapt(LeogamingPaymentMode).sendPhone(this.phoneForm.getPhoneNumber());
        this.proceedButton.visible = false;
      } else if(this.state == LeogamingPhonePaymentState.CONFIRM) {
        local2 = this.codeConfirmForm.getCodeConfirm();
        payMode.adapt(LeogamingPaymentMode).sendCode(local2);
        this.codeConfirmForm.clear();
        this.setWaitingPayment();
      }
    }

    private function onValid(param1:ValidationEvent) : void {
      this.proceedButton.visible = true;
    }

    private function onInvalid(param1:ValidationEvent) : void {
      this.proceedButton.visible = false;
    }

    private function render() : void {
      if(this.state == LeogamingPhonePaymentState.PHONE) {
        this.proceedButton.y = this.phoneForm.y + this.phoneForm.height + MARGIN;
      } else {
        this.proceedButton.y = this.codeConfirmForm.y + this.codeConfirmForm.height + MARGIN;
      }
      this.proceedButton.x = this.codeConfirmForm.x + this.codeConfirmForm.width - this.proceedButton.width;
    }

    override public function destroy() : void {
      this.phoneForm.removeEventListener(ValidationEvent.VALID,this.onValid);
      this.phoneForm.removeEventListener(ValidationEvent.INVALID,this.onInvalid);
      this.codeConfirmForm.removeEventListener(ValidationEvent.VALID,this.onValid);
      this.codeConfirmForm.removeEventListener(ValidationEvent.INVALID,this.onInvalid);
      this.proceedButton.removeEventListener(MouseEvent.CLICK,this.onProceedClicked);
      this.phoneForm.destroy();
      this.codeConfirmForm.destroy();
      super.destroy();
    }

    public function reset() : void {
      this.setPhoneForm();
      this.phoneForm.reset();
    }

    public function proceed() : void {
      if(this.state == LeogamingPhonePaymentState.PHONE) {
        this.setCodeConfirmForm();
      } else if(this.state == LeogamingPhonePaymentState.CONFIRM) {
        this.setWaitingPayment();
      }
    }
  }
}
