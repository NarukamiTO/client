package alternativa.tanks.gui.shop.components.window {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.country.CountryService;
  import base.DiscreteSprite;
  import controls.dropdownlist.DropDownList;
  import flash.events.Event;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;

  public class ShopWindowCountrySelector extends DiscreteSprite {
    [Inject]
    public static var countryService:CountryService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    public var autoReloadPayments:Boolean;

    private var chooseCountryComboBox:DropDownList = new DropDownList();

    public function ShopWindowCountrySelector(param1:Boolean = true) {
      super();
      this.chooseCountryComboBox.width = 160;
      this.initCountries();
      addChild(this.chooseCountryComboBox);
      this.autoReloadPayments = param1;
      this.chooseCountryComboBox.addEventListener(Event.CHANGE,this.onCountrySelected);
    }

    private function initCountries() : void {
      var local1:Vector.<CountryInfo> = countryService.getRegisteredCountries();
      var local2:int = 0;
      while(local2 < local1.length) {
        this.chooseCountryComboBox.addItem({
          "rang":0,
          "index":local2,
          "id":local2,
          "gameName":local1[local2].countryName,
          "code":local1[local2].countryCode
        });
        local2++;
      }
      this.chooseCountryComboBox.sortOn("gameName");
      if(Boolean(countryService.getDefaultCountryCode())) {
        this.chooseCountryComboBox.selectItemByField("code",countryService.getDefaultCountryCode());
      } else {
        this.chooseCountryComboBox.selectItemByField("id",0);
      }
    }

    private function onCountrySelected(param1:Event) : void {
      countryService.changeCountry(this.chooseCountryComboBox.selectedItem["code"]);
      if(this.autoReloadPayments) {
        paymentDisplayService.reloadPayment();
      }
    }

    override public function get height() : Number {
      return this.chooseCountryComboBox.rowHeight;
    }

    override public function get width() : Number {
      return this.chooseCountryComboBox.width;
    }
  }
}
