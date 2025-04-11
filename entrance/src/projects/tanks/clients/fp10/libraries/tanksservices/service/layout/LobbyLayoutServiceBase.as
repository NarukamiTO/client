package projects.tanks.clients.fp10.libraries.tanksservices.service.layout {
  import flash.events.IEventDispatcher;

  public interface LobbyLayoutServiceBase extends IEventDispatcher {
    function inBattle() : Boolean;
    function exitFromBattleToGarageThroughAlert() : void;
    function exitFromBattleWithoutNotify() : void;
  }
}
