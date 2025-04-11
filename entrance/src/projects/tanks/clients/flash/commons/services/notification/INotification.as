package projects.tanks.clients.flash.commons.services.notification {
  import alternativa.types.Long;
  import org.osflash.signals.Signal;

  public interface INotification {
    function show(param1:Signal) : void;
    function destroy() : void;
    function get userId() : Long;
    function get message() : String;
  }
}
