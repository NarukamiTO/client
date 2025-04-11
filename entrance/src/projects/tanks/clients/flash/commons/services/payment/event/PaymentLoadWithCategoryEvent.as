package projects.tanks.clients.flash.commons.services.payment.event {
  import flash.events.Event;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class PaymentLoadWithCategoryEvent extends Event {
    public static const LOAD_PAYMENT:String = "PAYMENT_SERVICE_LOAD_WITH_CATEGORY";

    private var _shopCategoryType:ShopCategoryEnum;

    public function PaymentLoadWithCategoryEvent(param1:ShopCategoryEnum) {
      super(LOAD_PAYMENT);
      this._shopCategoryType = param1;
    }

    public function get shopCategoryType() : ShopCategoryEnum {
      return this._shopCategoryType;
    }
  }
}
