package projects.tanks.clients.flash.commons.services.notification.sound {
  import flash.media.Sound;

  public interface INotificationSoundService {
    function set notificationSound(param1:Sound) : void;
    function playNotificationSound() : void;
  }
}
