package alternativa.tanks.service.country {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;
  import projects.tanks.client.panel.model.usercountry.UserCountryCC;

  public interface CountryService extends IEventDispatcher {
    function initService(param1:UserCountryCC) : void;
    function getRegisteredCountries() : Vector.<CountryInfo>;
    function getDefaultCountryCode() : String;
    function setDefaultCountryCode(param1:String) : void;
    function changeCountry(param1:String) : void;
    function chooseCountryForPayment() : void;
  }
}
