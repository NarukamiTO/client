package projects.tanks.clients.flash.commons.services.payment.event {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class PaymentLoadWithGarageItemEvent extends Event {
    public static const LOAD_PAYMENT:String = "PAYMENT_SERVICE_LOAD_WITH_GARAGE_ITEM";

    private var _garageItem:IGameObject;

    public function PaymentLoadWithGarageItemEvent(param1:IGameObject) {
      super(LOAD_PAYMENT);
      this._garageItem = param1;
    }

    public function get garageItem() : IGameObject {
      return this._garageItem;
    }
  }
}
