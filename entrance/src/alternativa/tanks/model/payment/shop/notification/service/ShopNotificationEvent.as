package alternativa.tanks.model.payment.shop.notification.service {
  import flash.events.Event;

  public class ShopNotificationEvent extends Event {
    public static const SHOW_NOTIFICATION_ABOUT_NEW_ITEMS:String = "showNotificationNewItems";
    public static const SHOW_NOTIFICATION_ABOUT_DISCOUNTS:String = "showNotificationDiscounts";
    public static const HIDE_NOTIFICATION:String = "hideNotification";

    public function ShopNotificationEvent(param1:String) {
      super(param1);
    }
  }
}
