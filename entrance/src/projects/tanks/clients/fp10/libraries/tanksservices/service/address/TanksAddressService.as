package projects.tanks.clients.fp10.libraries.tanksservices.service.address {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface TanksAddressService extends IEventDispatcher {
    function resetBattle() : void;
    function setBattle(param1:Long) : void;
    function setServer(param1:int) : void;
    function init(param1:int) : void;
    function back() : void;
    function getServerNumber() : int;
    function hasBattle() : Boolean;
    function getBattleId() : Long;
  }
}
