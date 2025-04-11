package alternativa.tanks.service.country.event {
  import flash.events.Event;

  public class ChooseCountryForPaymentEvent extends Event {
    public static const EVENT_TYPE:String = "ChooseCountryForPaymentEvent";

    public function ChooseCountryForPaymentEvent() {
      super(EVENT_TYPE);
    }
  }
}
