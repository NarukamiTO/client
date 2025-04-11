package alternativa.tanks.battle.events {
  public interface BattleEventDispatcher {
    function addBattleEventListener(param1:Class, param2:BattleEventListener) : void;
    function removeBattleEventListener(param1:Class, param2:BattleEventListener) : void;
    function dispatchEvent(param1:Object) : void;
    function dispatchEventOnce(param1:Object) : void;
    function clearDispatchedOnce() : void;
  }
}
