package alternativa.tanks.service.country {
  import alternativa.tanks.service.country.event.ChooseCountryForPaymentEvent;
  import alternativa.tanks.service.country.event.UserPaymentCountryChangedEvent;
  import flash.events.EventDispatcher;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;
  import projects.tanks.client.panel.model.usercountry.UserCountryCC;

  public class CountryServiceImpl extends EventDispatcher implements CountryService {
    private var registeredCountries:Vector.<CountryInfo>;
    private var defaultCountry:String;

    public function CountryServiceImpl() {
      super();
    }

    public function initService(param1:UserCountryCC) : void {
      this.registeredCountries = param1.countries;
      this.defaultCountry = param1.defaultCountryCode;
    }

    public function getRegisteredCountries() : Vector.<CountryInfo> {
      return this.registeredCountries;
    }

    public function getDefaultCountryCode() : String {
      return this.defaultCountry;
    }

    public function setDefaultCountryCode(param1:String) : void {
      this.defaultCountry = param1;
    }

    public function changeCountry(param1:String) : void {
      this.defaultCountry = param1;
      dispatchEvent(new UserPaymentCountryChangedEvent(UserPaymentCountryChangedEvent.USER_PAYMENT_COUNTRY_CHANGED,param1));
    }

    public function chooseCountryForPayment() : void {
      dispatchEvent(new ChooseCountryForPaymentEvent());
    }
  }
}
