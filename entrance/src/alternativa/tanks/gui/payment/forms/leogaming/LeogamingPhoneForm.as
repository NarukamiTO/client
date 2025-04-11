package alternativa.tanks.gui.payment.forms.leogaming {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberEvent;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberInput;
  import base.DiscreteSprite;
  import controls.labels.MouseDisabledLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LeogamingPhoneForm extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const LABEL_GAP:int = 7;
    private static const WIDTH:int = 280;

    private var phoneInput:PhoneNumberInput;
    private var phoneLabel:MouseDisabledLabel;

    public function LeogamingPhoneForm() {
      super();
      this.addPhoneLabel();
      this.addPhoneInput();
      this.render();
    }

    private function onNumberChanged(param1:PhoneNumberEvent) : void {
      if(param1.isCorrectLength()) {
        this.phoneInput.onValidNumber();
        dispatchEvent(new ValidationEvent(ValidationEvent.VALID));
      } else {
        this.phoneInput.onInvalidNumber();
        dispatchEvent(new ValidationEvent(ValidationEvent.INVALID));
      }
    }

    private function addPhoneLabel() : void {
      this.phoneLabel = new MouseDisabledLabel();
      this.phoneLabel.text = localeService.getText(TanksLocale.TEXT_PHONE_NUMBER);
      addChild(this.phoneLabel);
    }

    private function addPhoneInput() : void {
      this.phoneInput = new PhoneNumberInput(true);
      this.phoneInput.setCountryCode(380,9);
      this.phoneInput.addEventListener(PhoneNumberEvent.CHANGED,this.onNumberChanged);
      addChild(this.phoneInput);
    }

    public function getPhoneNumber() : String {
      return this.phoneInput.getPhoneNumber();
    }

    public function destroy() : void {
      this.phoneInput.removeEventListener(PhoneNumberEvent.CHANGED,this.onNumberChanged);
    }

    public function reset() : void {
      this.phoneInput.reset();
    }

    private function render() : void {
      this.phoneInput.x = WIDTH - this.phoneInput.width;
      this.phoneLabel.x = this.phoneInput.x - LABEL_GAP - this.phoneLabel.width;
      this.phoneLabel.y = this.phoneInput.height - this.phoneLabel.height >> 1;
    }
  }
}
