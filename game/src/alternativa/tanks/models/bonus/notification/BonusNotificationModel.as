package alternativa.tanks.models.bonus.notification {
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.notification.BonusNotificationModelBase;
  import projects.tanks.client.battlefield.models.bonus.bonus.notification.IBonusNotificationModelBase;

  [ModelInfo]
  public class BonusNotificationModel extends BonusNotificationModelBase implements IBonusNotificationModelBase, BonusNotification {
    public function BonusNotificationModel() {
      super();
    }

    public function getMessage() : String {
      return getInitParam().notificationMessage;
    }

    public function getMessageContainsUid() : String {
      return getInitParam().notificationMessageContainsUid;
    }

    public function getSoundNotification() : SoundResource {
      return getInitParam().soundNotification;
    }
  }
}
