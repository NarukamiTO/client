package alternativa.tanks.service.clan {
  import flash.events.IEventDispatcher;

  public interface ClanPanelNotificationService extends IEventDispatcher {
    function remove() : void;
    function add() : void;
    function init(param1:int) : void;
    function numberNotification() : int;
    function set restrictionTimeJoinClanInSec(param1:int) : void;
    function get restrictionTimeJoinClanInSec() : int;
    function get clanButtonVisible() : Boolean;
    function set clanButtonVisible(param1:Boolean) : void;
  }
}
