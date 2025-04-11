package projects.tanks.client.battleselect.model.battle.team {
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface ITeamBattleInfoModelBase {
    function addUser(param1:BattleInfoUser, param2:BattleTeam) : void;
    function removeUser(param1:Long) : void;
    function swapTeams() : void;
    function updateTeamScore(param1:BattleTeam, param2:int) : void;
    function updateUserScore(param1:Long, param2:int) : void;
  }
}
