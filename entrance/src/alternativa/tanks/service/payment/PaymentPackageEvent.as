package alternativa.tanks.service.payment {
  import flash.events.Event;

  public class PaymentPackageEvent extends Event {
    public static const PACKAGES_ADDED:String = "PaymentPackageEventPACKAGES_ADDED";

    public function PaymentPackageEvent(param1:String) {
      super(param1,true);
    }
  }
}
