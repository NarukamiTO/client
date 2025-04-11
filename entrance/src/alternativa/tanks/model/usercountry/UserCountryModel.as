package alternativa.tanks.model.usercountry {
  import alternativa.tanks.gui.selectcountry.SelectCountryAlert;
  import alternativa.tanks.service.country.CountryService;
  import alternativa.tanks.service.country.event.ChooseCountryForPaymentEvent;
  import alternativa.tanks.service.country.event.UserPaymentCountryChangedEvent;
  import alternativa.tanks.service.payment.IPaymentService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.usercountry.IUserCountryModelBase;
  import projects.tanks.client.panel.model.usercountry.UserCountryCC;
  import projects.tanks.client.panel.model.usercountry.UserCountryModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;

  [ModelInfo]
  public class UserCountryModel extends UserCountryModelBase implements IUserCountryModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var countryService:CountryService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var userPaymentActionService:UserPaymentActionsService;

    [Inject]
    public static var paymentService:IPaymentService;

    public function UserCountryModel() {
      super();
    }

    public function showPaymentWindow() : void {
      this.showPayment();
    }

    private function onChooseCountry(param1:ChooseCountryForPaymentEvent = null) : void {
      if(paymentService.shouldChooseLocation()) {
        server.checkUserPaymentCountry();
      } else {
        this.showPayment();
      }
    }

    private function setCurrentPaymentCountry(param1:String) : void {
      userPaymentActionService.selectCountry(param1);
      countryService.setDefaultCountryCode(param1);
      server.setCurrentPaymentCountry(param1);
      this.showPayment();
    }

    private function showPayment() : void {
      paymentDisplayService.loadPayment();
    }

    public function requestUserCountry(param1:String) : void {
      countryService.setDefaultCountryCode(param1);
      new SelectCountryAlert(getFunctionWrapper(this.setCurrentPaymentCountry));
    }

    public function objectLoaded() : void {
      var local1:UserCountryCC = getInitParam();
      countryService.initService(local1);
      paymentService.setShouldChooseLocation(local1.locationCheckEnabled);
      this.addEventListeners();
    }

    public function objectUnloaded() : void {
      this.removeEventListeners();
    }

    private function addEventListeners() : void {
      countryService.addEventListener(ChooseCountryForPaymentEvent.EVENT_TYPE,getFunctionWrapper(this.onChooseCountry));
      countryService.addEventListener(UserPaymentCountryChangedEvent.USER_PAYMENT_COUNTRY_CHANGED,getFunctionWrapper(this.setUserPaymentCountry));
    }

    private function removeEventListeners() : void {
      countryService.removeEventListener(ChooseCountryForPaymentEvent.EVENT_TYPE,getFunctionWrapper(this.onChooseCountry));
      countryService.removeEventListener(UserPaymentCountryChangedEvent.USER_PAYMENT_COUNTRY_CHANGED,getFunctionWrapper(this.setUserPaymentCountry));
    }

    private function setUserPaymentCountry(param1:UserPaymentCountryChangedEvent) : void {
      server.setCurrentPaymentCountry(param1.countryCode);
      userPaymentActionService.selectCountry(param1.countryCode);
    }
  }
}
