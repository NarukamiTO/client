package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface TeamScoreIndicator {
    function setTeamScore(param1:BattleTeam, param2:int) : void;
    function setScore(param1:int, param2:int) : void;
  }
}
