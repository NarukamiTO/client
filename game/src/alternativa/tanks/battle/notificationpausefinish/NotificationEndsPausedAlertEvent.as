package alternativa.tanks.battle.notificationpausefinish {
  import flash.events.Event;

  public class NotificationEndsPausedAlertEvent extends Event {
    public static const RETURN_TO_BATTLE:String = "NotificationEndsPausedAlertEvent.RETURN_TO_BATTLE";
    public static const CLOSE_ALERT:String = "NotificationEndsPausedAlertEvent.CLOSE_ALERT";

    public function NotificationEndsPausedAlertEvent(param1:String) {
      super(param1);
    }
  }
}
