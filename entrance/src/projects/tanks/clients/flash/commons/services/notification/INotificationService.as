package projects.tanks.clients.flash.commons.services.notification {
  import alternativa.types.Long;

  public interface INotificationService {
    function addNotification(param1:INotification, param2:Boolean = false) : void;
    function hasNotification(param1:Long, param2:String) : Boolean;
  }
}
