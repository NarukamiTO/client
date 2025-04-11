package alternativa.tanks.model.payment.shop.notification.service {
  import flash.events.EventDispatcher;

  public class ShopNotifierServiceImpl extends EventDispatcher implements ShopNotifierService {
    public function ShopNotifierServiceImpl() {
      super();
    }

    public function showNotificationAboutNewItems() : void {
      dispatchEvent(new ShopNotificationEvent(ShopNotificationEvent.SHOW_NOTIFICATION_ABOUT_NEW_ITEMS));
    }

    public function showNotificationAboutDiscounts() : void {
      dispatchEvent(new ShopNotificationEvent(ShopNotificationEvent.SHOW_NOTIFICATION_ABOUT_DISCOUNTS));
    }

    public function hideNotification() : void {
      dispatchEvent(new ShopNotificationEvent(ShopNotificationEvent.HIDE_NOTIFICATION));
    }
  }
}
