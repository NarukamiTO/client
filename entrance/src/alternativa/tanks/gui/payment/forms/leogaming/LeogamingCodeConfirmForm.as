package alternativa.tanks.gui.payment.forms.leogaming {
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import controls.base.TankInputBase;
  import controls.labels.MouseDisabledLabel;
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LeogamingCodeConfirmForm extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const LABEL_GAP:int = 7;
    private static const WIDTH:int = 280;
    private static const MIN_CHARS:int = 5;

    private var codeInput:TankInputBase;
    private var codeLabel:MouseDisabledLabel;

    public function LeogamingCodeConfirmForm() {
      super();
      this.addPhoneLabel();
      this.addCodeInput();
      this.render();
    }

    public function getCodeConfirm() : String {
      return this.codeInput.value;
    }

    private function addPhoneLabel() : void {
      this.codeLabel = new MouseDisabledLabel();
      this.codeLabel.text = localeService.getText(TanksLocale.TEXT_CODE_CONFIRM);
      addChild(this.codeLabel);
    }

    private function addCodeInput() : void {
      this.codeInput = new TankInputBase();
      this.codeInput.width = 150;
      this.codeInput.textField.width = 90;
      this.codeInput.textField.text = "";
      this.codeInput.textField.maxChars = 6;
      this.codeInput.textField.restrict = "0-9";
      this.codeInput.validValue = true;
      this.codeInput.addEventListener(Event.CHANGE,this.onCodeChanged);
      addChild(this.codeInput);
    }

    private function onCodeChanged(param1:Event) : void {
      if(this.codeInput.textField.text.length >= MIN_CHARS) {
        dispatchEvent(new ValidationEvent(ValidationEvent.VALID));
      } else {
        dispatchEvent(new ValidationEvent(ValidationEvent.INVALID));
      }
    }

    public function clear() : void {
      this.codeInput.textField.text = "";
    }

    public function destroy() : void {
      this.codeInput.removeEventListener(Event.CHANGE,this.onCodeChanged);
    }

    private function render() : void {
      this.codeInput.x = WIDTH - this.codeInput.width;
      this.codeLabel.x = this.codeInput.x - LABEL_GAP - this.codeLabel.width;
      this.codeLabel.y = this.codeInput.height - this.codeLabel.height >> 1;
    }
  }
}
