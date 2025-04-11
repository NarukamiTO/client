package alternativa.tanks.gui.payment.forms.mobile {
  import alternativa.osgi.service.display.IDisplay;
  import assets.icons.InputCheckIcon;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.events.Event;

  public class PhoneNumberInput extends TankInputBase {
    [Inject]
    public static var displayService:IDisplay;

    private var phoneLength:int = 10;
    private var countryCode:String = "7";
    private var countryCodeLabel:LabelBase = new LabelBase();
    private var wait:InputCheckIcon = new InputCheckIcon();

    public function PhoneNumberInput(param1:Boolean = false) {
      super();
      restrict = "0-9";
      maxChars = 15;
      width = param1 ? 150 : 115;
      textField.width = 90;
      textField.text = "";
      this.countryCodeLabel.width = 30;
      this.countryCodeLabel.text = "+7";
      addChild(this.countryCodeLabel);
      this.countryCodeLabel.x = 3;
      this.countryCodeLabel.y = textField.y;
      textField.x = this.countryCodeLabel.x + this.countryCodeLabel.textWidth + 3;
      validValue = true;
      textField.addEventListener(Event.CHANGE,this.onTextChange);
    }

    private function onTextChange(param1:Event = null) : void {
      var local2:Boolean = textField.text.length == this.phoneLength;
      if(local2) {
        this.waiting();
        displayService.stage.focus = null;
        textField.mouseEnabled = false;
      } else {
        this.hideWait();
      }
      dispatchEvent(new PhoneNumberEvent(PhoneNumberEvent.CHANGED,this.getPhoneNumber(),local2));
    }

    public function isPhoneNonEmpty() : Boolean {
      return textField.text.length > 0;
    }

    public function setCountryCode(param1:int, param2:int) : void {
      this.phoneLength = param2;
      maxChars = param2;
      this.countryCode = param1.toString();
      this.countryCodeLabel.text = "+" + this.countryCode;
      textField.x = this.countryCodeLabel.x + this.countryCodeLabel.textWidth + 3;
      this.onTextChange();
    }

    public function getPhoneNumber() : String {
      return this.countryCode + textField.text;
    }

    public function onValidNumber() : void {
      this.showWait(2);
      textField.mouseEnabled = true;
    }

    public function onInvalidNumber() : void {
      this.showWait(3);
      textField.mouseEnabled = true;
      displayService.stage.focus = textField;
    }

    public function waiting() : void {
      this.showWait(1);
    }

    private function showWait(param1:int) : void {
      if(this.wait.parent == null) {
        addChild(this.wait);
      }
      this.wait.gotoAndStop(param1);
      this.wait.x = width - this.wait.width - 15;
      this.wait.y = height - this.wait.height >> 1;
    }

    private function hideWait() : void {
      if(this.wait.parent != null) {
        removeChild(this.wait);
      }
    }

    public function reset() : void {
      textField.text = "";
      this.hideWait();
      textField.mouseEnabled = true;
      displayService.stage.focus = textField;
    }
  }
}
