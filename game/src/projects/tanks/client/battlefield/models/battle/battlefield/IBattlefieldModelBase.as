package projects.tanks.client.battlefield.models.battle.battlefield {
  import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;
  import projects.tanks.client.battleservice.BattleRoundParameters;

  public interface IBattlefieldModelBase {
    function battleFinish() : void;
    function battleRestart() : void;
    function battleStart(param1:BattleRoundParameters) : void;
    function traceHit(param1:HitTraceData) : void;
  }
}
