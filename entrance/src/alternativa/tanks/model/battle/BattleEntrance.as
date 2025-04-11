package alternativa.tanks.model.battle {
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInterface]
  public interface BattleEntrance {
    function fight(param1:BattleTeam = null) : void;
    function enterAsSpectator() : void;
  }
}
