package alternativa.tanks.gui.payment.forms.qiwi {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.mobile.*;
  import base.DiscreteSprite;
  import controls.Label;
  import controls.dropdownlist.DropDownList;
  import controls.labels.MouseDisabledLabel;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class QiwiPhoneNumberForm extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const INPUT_WIDTH:int = 150;
    private static const CODE_FIELD:String = "code";
    private static const PHONE_LENGTH_FIELD:String = "phoneLength";

    private const DEFAULT_COUNTRY_CODE:int = 7;

    private var countryCodesLabel:Label;

    internal var countryCodesList:DropDownList;

    private var phoneLabel:Label;

    internal var phoneInput:PhoneNumberInput;
    internal var proceedButton:ProceedButton;

    public function QiwiPhoneNumberForm(param1:Vector.<CountryPhoneInfo>) {
      super();
      this.addPhoneElement();
      this.addProceedButton();
      this.addCountryElement();
      this.initCountryList(param1);
      this.render();
    }

    private static function onMouseWheel(param1:MouseEvent) : void {
      param1.stopImmediatePropagation();
    }

    private function addCountryElement() : void {
      this.countryCodesLabel = new MouseDisabledLabel();
      this.countryCodesLabel.text = "Код страны:";
      addChild(this.countryCodesLabel);
      this.countryCodesList = new DropDownList();
      this.countryCodesList.width = INPUT_WIDTH;
      this.countryCodesList.height = QiwiForm.HEIGHT;
      addChild(this.countryCodesList);
    }

    private function addPhoneElement() : void {
      this.phoneLabel = new MouseDisabledLabel();
      this.phoneLabel.text = "Номер телефона:";
      addChild(this.phoneLabel);
      this.phoneInput = new PhoneNumberInput(true);
      addChild(this.phoneInput);
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      this.proceedButton.visible = false;
      addChild(this.proceedButton);
    }

    public function initCountryList(param1:Vector.<CountryPhoneInfo>) : void {
      var local2:CountryPhoneInfo = null;
      var local3:String = null;
      for each(local2 in param1) {
        local3 = "+" + local2.code + " " + local2.name;
        this.countryCodesList.addItem({
          "gameName":local3,
          "rang":0,
          "code":local2.code,
          "phoneLength":local2.phoneLength
        });
      }
      this.countryCodesList.sortOn(CODE_FIELD,[Array.NUMERIC]);
      this.countryCodesList.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
      this.countryCodesList.addEventListener(Event.CHANGE,this.onCountryChanged);
      this.setDefaultCountryCode();
    }

    private function onCountryChanged(param1:Event) : void {
      this.phoneInput.setCountryCode(this.countryCodesList.selectedItem[CODE_FIELD],this.countryCodesList.selectedItem[PHONE_LENGTH_FIELD]);
    }

    public function setDefaultCountryCode() : void {
      this.countryCodesList.selectItemByField(CODE_FIELD,this.DEFAULT_COUNTRY_CODE);
    }

    private function render() : void {
      this.countryCodesList.x = this.phoneInput.x = QiwiForm.WIDTH - INPUT_WIDTH;
      this.phoneInput.y = this.phoneInput.height + 10;
      this.countryCodesLabel.y = this.phoneInput.height - this.countryCodesLabel.height >> 1;
      this.phoneLabel.y = this.phoneInput.y + (this.phoneInput.height - this.phoneLabel.height >> 1);
      this.proceedButton.x = QiwiForm.WIDTH - this.proceedButton.width >> 1;
      this.proceedButton.y = QiwiForm.HEIGHT - this.proceedButton.height;
    }

    public function reset() : void {
      this.phoneInput.reset();
      this.proceedButton.visible = false;
    }

    override public function get width() : Number {
      return QiwiForm.WIDTH;
    }

    override public function get height() : Number {
      return QiwiForm.HEIGHT;
    }
  }
}
