package alternativa.tanks.battle {
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface TeamDMTargetEvaluator {
    function setLocalTeamType(param1:BattleTeam) : void;
  }
}
