package alternativa.tanks.servermodels.pushnotification {
  import projects.tanks.client.entrance.model.entrance.notificationtoken.INotificationTokenModelBase;
  import projects.tanks.client.entrance.model.entrance.notificationtoken.NotificationTokenModelBase;

  [ModelInfo]
  public class NotificationTokenModel extends NotificationTokenModelBase implements INotificationTokenModelBase {
    public function NotificationTokenModel() {
      super();
    }
  }
}
