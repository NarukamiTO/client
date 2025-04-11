package alternativa.tanks.gui.payment.forms.platbox {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberEvent;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberInput;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberValidationEvent;
  import base.DiscreteSprite;
  import controls.Label;
  import controls.labels.MouseDisabledLabel;
  import flash.events.MouseEvent;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.payment.PayModeProceed;

  public class PlatboxPhoneNumberForm extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const LABEL_GAP:int = 7;
    private static const PHONE_CHECK_DELAY:int = 500;

    private var payMode:IGameObject;
    private var phoneInput:PhoneNumberInput;
    private var phoneLabel:Label;
    private var proceedButton:ProceedButton;
    private var timeout:int = -1;

    public function PlatboxPhoneNumberForm(param1:IGameObject) {
      super();
      this.payMode = param1;
      this.addPhoneLabel();
      this.addPhoneInput();
      this.addProceedButton();
      this.render();
    }

    private function addPhoneLabel() : void {
      this.phoneLabel = new MouseDisabledLabel();
      this.phoneLabel.text = "Номер телефона:";
      addChild(this.phoneLabel);
    }

    private function addPhoneInput() : void {
      this.phoneInput = new PhoneNumberInput();
      this.phoneInput.addEventListener(PhoneNumberEvent.CHANGED,this.onNumberChanged);
      addChild(this.phoneInput);
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClick);
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      this.proceedButton.visible = false;
      addChild(this.proceedButton);
    }

    private function onNumberChanged(param1:PhoneNumberEvent) : void {
      this.resetTimeout();
      if(param1.isCorrectLength()) {
        this.phoneInput.waiting();
        this.timeout = setTimeout(this.sendValidationRequest,PHONE_CHECK_DELAY);
      } else {
        this.phoneInput.onInvalidNumber();
        this.proceedButton.visible = false;
      }
    }

    private function sendValidationRequest() : void {
      this.resetTimeout();
      dispatchEvent(new PhoneNumberValidationEvent(this.phoneInput.value));
    }

    private function resetTimeout() : void {
      if(this.timeout != -1) {
        clearTimeout(this.timeout);
        this.timeout = -1;
      }
    }

    private function onProceedClick(param1:MouseEvent) : void {
      PayModeProceed(this.payMode.adapt(PayModeProceed)).proceedPayment();
      dispatchEvent(new ProceedPaymentEvent());
    }

    public function reset() : void {
      this.phoneInput.reset();
      this.proceedButton.visible = false;
    }

    public function get phoneNumber() : String {
      return this.phoneInput.getPhoneNumber();
    }

    private function render() : void {
      var local1:int = this.phoneInput.width + this.phoneLabel.width + LABEL_GAP;
      this.phoneLabel.x = PlatBoxForm.WIDTH - local1 >> 1;
      this.phoneInput.x = this.phoneLabel.x + this.phoneLabel.width + LABEL_GAP;
      this.phoneLabel.y = this.phoneInput.height - this.phoneLabel.height >> 1;
      this.proceedButton.x = PlatBoxForm.WIDTH - this.proceedButton.width >> 1;
      this.proceedButton.y = PlatBoxForm.HEIGHT - this.proceedButton.height;
    }

    public function showPhoneIsInvalid(param1:String) : void {
      if(this.phoneInput.value == param1) {
        this.phoneInput.onInvalidNumber();
      }
    }

    public function showPhoneIsValid(param1:String) : void {
      if(this.phoneInput.value == param1) {
        this.phoneInput.onValidNumber();
        this.proceedButton.visible = true;
      }
    }
  }
}
