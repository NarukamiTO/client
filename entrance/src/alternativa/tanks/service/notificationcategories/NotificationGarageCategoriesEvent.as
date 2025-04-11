package alternativa.tanks.service.notificationcategories {
  import flash.events.Event;

  public class NotificationGarageCategoriesEvent extends Event {
    public static const NOTIFICATION_CHANGE:String = "NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE";

    public function NotificationGarageCategoriesEvent(param1:String) {
      super(param1);
    }
  }
}
