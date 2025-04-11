package projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public interface IBattleLinkActivatorService extends IEventDispatcher {
    function activateBattle(param1:BattleInfoData) : void;
    function activateBattleById(param1:Long) : void;
    function navigateToBattleUrl(param1:BattleInfoData) : void;
    function navigate(param1:BattleInfoData) : void;
    function navigateToBattleUrlWithoutAvailableBattle(param1:BattleInfoData) : void;
    function isAlive(param1:Long) : void;
    function alive(param1:Long) : void;
    function dead(param1:Long) : void;
  }
}
