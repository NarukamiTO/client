package alternativa.tanks.gui.shop.payment.promo {
  import flash.events.Event;

  public class SendPromoCodeEvent extends Event {
    public static var SEND_PROMO_CODE:String = "SendPromoCodeEvent";

    private var promoCode:String;

    public function SendPromoCodeEvent(param1:String) {
      this.promoCode = param1;
      super(SEND_PROMO_CODE);
    }

    public function getPromoCode() : String {
      return this.promoCode;
    }
  }
}
