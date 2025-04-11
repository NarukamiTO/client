package projects.tanks.clients.fp10.libraries.tanksservices.service.battle {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.battleservice.BattleRoundParameters;

  public interface IBattleInfoService extends IEventDispatcher {
    function get currentSelectionBattleId() : Long;
    function get currentBattleId() : Long;
    function set currentBattleId(param1:Long) : void;
    function setCurrentSelectionBattle(param1:Long, param2:int, param3:int) : void;
    function setCurrentSelectionBattleAndNotify(param1:Long, param2:int, param3:int) : void;
    function resetCurrentSelectionBattleId() : void;
    function forceResetCurrentSelectionBattleId() : void;
    function hasCurrentSelectionBattleId() : Boolean;
    function hasCurrentBattleId() : Boolean;
    function isSpectatorMode() : Boolean;
    function set spectatorMode(param1:Boolean) : void;
    function get reArmorEnabled() : Boolean;
    function get enterGarageCausesExitBattle() : Boolean;
    function set enterGarageCausesExitBattle(param1:Boolean) : void;
    function set reArmorEnabled(param1:Boolean) : void;
    function get withoutSupplies() : Boolean;
    function set withoutSupplies(param1:Boolean) : void;
    function get withoutBonuses() : Boolean;
    function get withoutDrones() : Boolean;
    function set withoutBonuses(param1:Boolean) : void;
    function set withoutDrones(param1:Boolean) : void;
    function availableRank(param1:int) : Boolean;
    function isAvailableSelectionBattle() : Boolean;
    function restoreCurrentBattleIdInAddressService() : void;
    function battleRestart() : void;
    function battleLoad() : void;
    function resetCurrentBattle() : void;
    function battleStart(param1:BattleRoundParameters) : void;
    function get running() : Boolean;
    function set running(param1:Boolean) : void;
    function isInBattle() : Boolean;
    function setInBattle(param1:Boolean) : void;
  }
}
