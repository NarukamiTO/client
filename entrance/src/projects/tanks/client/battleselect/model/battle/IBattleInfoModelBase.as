package projects.tanks.client.battleselect.model.battle {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;

  public interface IBattleInfoModelBase {
    function resetBattleName() : void;
    function roundFinished() : void;
    function roundStarted(param1:int) : void;
    function setBattleName(param1:String) : void;
    function updateSuspicion(param1:BattleSuspicionLevel) : void;
    function updateUserSuspiciousState(param1:Long, param2:Boolean) : void;
  }
}
