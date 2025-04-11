package alternativa.tanks.model.payment.shop.notification.service {
  import flash.events.IEventDispatcher;

  public interface ShopNotifierService extends IEventDispatcher {
    function showNotificationAboutNewItems() : void;
    function showNotificationAboutDiscounts() : void;
    function hideNotification() : void;
  }
}
