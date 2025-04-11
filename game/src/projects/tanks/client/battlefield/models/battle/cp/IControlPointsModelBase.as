package projects.tanks.client.battlefield.models.battle.cp {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface IControlPointsModelBase {
    function pointCaptureStarted(param1:BattleTeam) : void;
    function pointCaptureStopped(param1:BattleTeam) : void;
    function setPointProgress(param1:int, param2:Number, param3:Number) : void;
    function setPointState(param1:int, param2:ControlPointState) : void;
    function stopBattle() : void;
    function tankEnteredPointZone(param1:int, param2:Long) : void;
    function tankLeftPointZone(param1:int, param2:Long) : void;
  }
}
