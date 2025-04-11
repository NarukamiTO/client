package alternativa.tanks.service.country.event {
  import flash.events.Event;

  public class UserPaymentCountryChangedEvent extends Event {
    public static const USER_PAYMENT_COUNTRY_CHANGED:String = "UserPaymentCountryChangedEventUSER_PAYMENT_COUNTRY_CHANGED";

    public var countryCode:String;

    public function UserPaymentCountryChangedEvent(param1:String, param2:String) {
      super(param1,true);
      this.countryCode = param2;
    }
  }
}
