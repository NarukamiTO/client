package alternativa.tanks.models.bonus.notification {
  import platform.client.fp10.core.resource.types.SoundResource;

  [ModelInterface]
  public interface BonusNotification {
    function getMessage() : String;
    function getMessageContainsUid() : String;
    function getSoundNotification() : SoundResource;
  }
}
