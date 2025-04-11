package projects.tanks.clients.flash.commons.services.payment.event {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class PaymentLoadWithShopItemEvent extends Event {
    public static const LOAD_PAYMENT:String = "PAYMENT_SERVICE_LOAD_WITH_SHOP_ITEM";

    private var _shopItem:IGameObject;

    public function PaymentLoadWithShopItemEvent(param1:IGameObject) {
      super(LOAD_PAYMENT);
      this._shopItem = param1;
    }

    public function get shopItem() : IGameObject {
      return this._shopItem;
    }
  }
}
