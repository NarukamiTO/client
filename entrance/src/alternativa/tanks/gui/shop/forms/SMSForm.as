package alternativa.tanks.gui.shop.forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.events.PaymentFormEvent;
  import alternativa.tanks.gui.payment.events.SMSformEvent;
  import alternativa.tanks.gui.payment.forms.*;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import alternativa.tanks.model.payment.modes.sms.SMSPayMode;
  import alternativa.tanks.service.country.CountryService;
  import alternativa.tanks.service.payment.IPaymentService;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.dropdownlist.DropDownList;
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.geom.Point;
  import forms.payment.PaymentList;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSNumber;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSOperator;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import utils.TextUtils;

  public class SMSForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var countryService:CountryService;

    private const windowMargin:int = 11;
    private const spaceModule:int = 7;

    private var countriesCombo:DropDownList;
    private var operatorsCombo:DropDownList;
    private var comboLabelWidth:int = 50;
    private var smsTextLabel:LabelBase;
    private var smsText:LabelBase;
    private var smsTextBmp:Bitmap;
    private var numbers:Vector.<SMSNumber>;
    private var numbersList:PaymentList;
    private var numbersListInner:TankWindowInner;
    private var smsTextInner:TankWindowInner;
    private var oneText:Boolean;
    private var size:Point;

    public function SMSForm(param1:IGameObject) {
      super(param1);
      this.size = new Point();
      this.numbersListInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.numbersListInner.showBlink = true;
      addChild(this.numbersListInner);
      this.smsTextInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.smsTextInner.showBlink = true;
      addChild(this.smsTextInner);
      this.numbersList = new PaymentList();
      addChild(this.numbersList);
      this.smsTextLabel = new LabelBase();
      this.smsTextLabel.text = localeService.getText(TanksLocale.TEXT_PAYMENT_SMSTEXT_HEADER_LABEL_TEXT);
      addChild(this.smsTextLabel);
      this.smsText = new LabelBase();
      this.smsTextBmp = new Bitmap();
      addChild(this.smsTextBmp);
      this.operatorsCombo = new DropDownList();
      addChild(this.operatorsCombo);
      this.operatorsCombo.label = localeService.getText(TanksLocale.TEXT_PAYMENT_OPERATORS_LABEL_TEXT);
      this.countriesCombo = new DropDownList();
      addChild(this.countriesCombo);
      this.countriesCombo.label = localeService.getText(TanksLocale.TEXT_PAYMENT_COUNTRIES_LABEL_TEXT);
      this.operatorsCombo.addEventListener(Event.CHANGE,this.onOperatorSelect);
      this.countriesCombo.addEventListener(Event.CHANGE,this.onCountrySelect);
      this.numbersList.withSMSText = false;
      this.smsTextInner.visible = false;
      this.smsTextLabel.visible = false;
      this.smsTextBmp.visible = false;
      this.resize(ShopWindow.WINDOW_WIDTH - ShopWindow.WINDOW_PADDING * 2,250);
    }

    override public function set width(param1:Number) : void {
      this.size.x = param1;
      this.resize(this.size.x,this.size.y);
    }

    override public function set height(param1:Number) : void {
      this.size.y = param1;
      this.resize(this.size.x,this.size.y);
    }

    public function resize(param1:int, param2:int) : void {
      var local3:int = 0;
      this.size.x = param1;
      this.size.y = param2;
      this.countriesCombo.width = int(param1 * 0.5) - this.comboLabelWidth - this.windowMargin;
      this.operatorsCombo.width = int(param1 * 0.5) - this.comboLabelWidth - this.windowMargin;
      this.countriesCombo.x = this.comboLabelWidth;
      this.operatorsCombo.x = int(param1 * 0.5) + this.comboLabelWidth + this.windowMargin;
      this.graphics.drawRect(this.comboLabelWidth,0,int(param1 * 0.5) - this.comboLabelWidth - this.windowMargin,this.countriesCombo.height);
      this.graphics.drawRect(int(param1 * 0.5) + this.comboLabelWidth + this.windowMargin,0,int(param1 * 0.5) - this.comboLabelWidth - this.windowMargin,this.operatorsCombo.height);
      if(this.oneText) {
        this.smsTextInner.width = param1 - this.comboLabelWidth;
        this.smsTextInner.height = 50;
        this.smsTextInner.x = this.comboLabelWidth;
        this.smsTextInner.y = this.spaceModule * 5;
        if(this.smsText.text != null && this.smsText.text != "") {
          local3 = Math.max(12,Math.min(12 + int((this.size.x - 447) * 0.03) + int((28 - this.smsText.text.length) * 0.3),20));
          this.smsText.size = local3;
          this.smsTextBmp.bitmapData = TextUtils.getTextInCells(this.smsText,11 * (local3 / 12),16 * (local3 / 12));
          this.smsTextBmp.x = this.smsTextInner.x + this.spaceModule * 2;
          this.smsTextBmp.y = this.smsTextInner.y + (this.smsTextInner.height - this.smsTextBmp.height >> 1);
        }
        this.smsTextLabel.x = this.smsTextInner.x - this.spaceModule - this.smsTextLabel.width;
        this.smsTextLabel.y = this.smsTextInner.y + (this.smsTextInner.height - this.smsTextLabel.height >> 1);
        this.numbersListInner.y = this.smsTextInner.y + this.smsTextInner.height + this.spaceModule;
      } else {
        this.numbersListInner.y = this.spaceModule * 5;
      }
      this.numbersListInner.width = param1;
      this.numbersListInner.height = param2 - this.numbersListInner.y;
      this.numbersList.x = 5;
      this.numbersList.y = this.numbersListInner.y + 5;
      this.numbersList.width = param1 - 10;
      this.numbersList.height = param2 - this.numbersListInner.y - 10;
    }

    override public function activate() : void {
      var local1:Vector.<Country> = SMSPayMode(payMode.adapt(SMSPayMode)).getCountries();
      this.setCountries(local1);
      var local2:String = countryService.getDefaultCountryCode();
      if(local2 == null) {
        local2 = storageService.getStorage().data.userCountryId;
      }
      if(local2 != null && this.countriesCombo.findItemIndexByField("id",local2) == -1) {
        local2 = null;
      }
      if(local2 == null) {
        switch(localeService.language) {
          case "ru":
            local2 = "RU";
            break;
          case "cn":
            local2 = "CN";
            break;
          case "de":
            local2 = "DE";
            break;
          case "en":
            local2 = "UK";
        }
      }
      this.countriesCombo.selectItemByField("id",local2);
    }

    public function setCountries(param1:Vector.<Country>) : void {
      var local3:Country = null;
      this.countriesCombo.clear();
      var local2:int = 0;
      while(local2 < param1.length) {
        local3 = param1[local2] as Country;
        this.countriesCombo.addItem({
          "gameName":local3.name,
          "rang":0,
          "id":local3.id
        });
        local2++;
      }
      this.countriesCombo.sortOn("gameName");
    }

    public function setOperators(param1:Vector.<SMSOperator>) : void {
      var local5:SMSOperator = null;
      var local2:String = "";
      var local3:String = storageService.getStorage().data.userOperatorId;
      this.operatorsCombo.clear();
      this.smsString = "";
      var local4:int = 0;
      while(local4 < param1.length) {
        local5 = param1[local4] as SMSOperator;
        this.operatorsCombo.addItem({
          "gameName":local5.name,
          "rang":0,
          "id":local5.id
        });
        if(local3 != null && local5.id == int(local3)) {
          local2 = local5.name;
        }
        local4++;
      }
      this.operatorsCombo.sortOn("gameName");
      if(local2 != "") {
        this.operatorsCombo.value = local2;
      } else {
        this.clearOperators();
        this.clearNumbers();
      }
    }

    public function clearOperators() : void {
      this.operatorsCombo.selectedItem = null;
    }

    public function setNumbers(param1:Vector.<SMSNumber>) : void {
      this.numbers = param1;
      this.numbers.sort(this.sortNumbersByCost);
      this.numbersList.clear();
      var local2:SMSNumber = param1[0] as SMSNumber;
      var local3:String = local2.smsText;
      var local4:Boolean = false;
      var local5:int = 1;
      while(local5 < param1.length) {
        local2 = param1[local5] as SMSNumber;
        if(local2.smsText != local3) {
          local4 = true;
          break;
        }
        local5++;
      }
      this.oneTextForAllNumbers = !local4;
      local5 = 0;
      while(local5 < param1.length) {
        local2 = param1[local5] as SMSNumber;
        if(local2.currency == "£") {
          this.numbersList.addItem(local2.number,local2.currency,local2.cost.toFixed(2),local2.crystals,local4 ? local2.smsText : "");
        } else {
          this.numbersList.addItem(local2.number,local2.cost.toFixed(2),local2.currency,local2.crystals,local4 ? local2.smsText : "");
        }
        local5++;
      }
      if(!local4) {
        this.smsString = local3;
      }
    }

    public function clearNumbers() : void {
      this.numbersList.clear();
    }

    public function set smsString(param1:String) : void {
      if(param1 != null && param1 != "") {
        this.smsTextBmp.visible = true;
        this.smsText.text = param1;
        this.resize(this.size.x,this.size.y);
      } else {
        this.smsText.text = "";
        this.smsTextBmp.visible = false;
      }
    }

    public function set oneTextForAllNumbers(param1:Boolean) : void {
      this.oneText = param1;
      this.numbersList.withSMSText = !param1;
      this.smsTextInner.visible = param1;
      this.smsTextLabel.visible = param1;
      this.smsTextBmp.visible = param1;
      this.resize(this.size.x,this.size.y);
    }

    public function get selectedCountry() : String {
      return this.countriesCombo.selectedItem != null ? this.countriesCombo.selectedItem["id"] : "";
    }

    public function get selectedOperator() : int {
      return this.operatorsCombo.selectedItem != null ? int(this.operatorsCombo.selectedItem["id"]) : -1;
    }

    public function get selectedOperatorName() : String {
      return this.operatorsCombo.selectedItem != null ? String(this.operatorsCombo.selectedItem["gameName"]) : "";
    }

    private function onCountrySelect(param1:Event) : void {
      dispatchEvent(new SMSformEvent(SMSformEvent.SELECT_COUNTRY,this));
      dispatchEvent(new PaymentFormEvent(PaymentFormEvent.SUBSYSTEM_SELECTED));
    }

    private function onOperatorSelect(param1:Event) : void {
      dispatchEvent(new SMSformEvent(SMSformEvent.SELECT_OPERATOR,this));
      dispatchEvent(new PaymentFormEvent(PaymentFormEvent.SUBSYSTEM_SELECTED));
    }

    private function sortNumbersByCost(param1:SMSNumber, param2:SMSNumber) : int {
      var local3:int = 0;
      if(param1.cost > param2.cost) {
        local3 = -1;
      } else if(param1.cost < param2.cost) {
        local3 = 1;
      } else {
        local3 = 0;
      }
      return local3;
    }

    public function getDescription() : String {
      var local1:String = "";
      var local2:String = "МТС";
      if(localeService.language == "ru") {
        if(this.selectedCountry == "UA") {
          return localeService.getText(TanksLocale.TEXT_PAYMENT_UKRAINE_SMS_INFO) + "\n";
        }
        if(this.selectedCountry == "RU" && this.selectedOperatorName == local2) {
          return local1 + "\n" + localeService.getText(TanksLocale.TEXT_PAYMENT_MTS_ADDITIONAL_INFO) + "\n";
        }
      }
      if(this.selectedCountry == "PT") {
        return localeService.getText(TanksLocale.TEXT_PAYMENT_SMS_DESCRIPTION_TEXT_INCLUDING_VAT) + "\n";
      }
      if(this.selectedCountry == "UK" && localeService.language == "en") {
        return local1 + "\n" + localeService.getText(TanksLocale.TEXT_PAYMENT_SMS_UK_DESCRIPTION_ENDING_TEXT) + "\n";
      }
      if(this.selectedCountry == "CO" && localeService.language == "es") {
        return localeService.getText(TanksLocale.TEXT_PAYMENT_SMS_DESCRIPTION_CO_TEXT) + "\n";
      }
      return local1;
    }

    override public function isWithoutChosenItem() : Boolean {
      return true;
    }

    override public function getMinHeight() : int {
      return 450;
    }
  }
}
