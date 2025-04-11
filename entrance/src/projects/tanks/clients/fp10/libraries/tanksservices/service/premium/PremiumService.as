package projects.tanks.clients.fp10.libraries.tanksservices.service.premium {
  import flash.events.IEventDispatcher;

  public interface PremiumService extends IEventDispatcher {
    function hasPremium() : Boolean;
    function updateTimeLeft(param1:int) : void;
    function getTimeLeft() : int;
    function destroy() : void;
  }
}
