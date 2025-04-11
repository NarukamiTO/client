package projects.tanks.client.battleservice.model.statistics.team {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public interface IStatisticsTeamModelBase {
    function changeTeamScore(param1:BattleTeam, param2:int) : void;
    function changeUserStat(param1:UserStat, param2:BattleTeam) : void;
    function refreshUsersStat(param1:Vector.<UserStat>, param2:BattleTeam) : void;
    function swapTeam(param1:Vector.<UserStat>, param2:Vector.<UserStat>) : void;
    function userConnect(param1:Long, param2:Vector.<UserInfo>, param3:BattleTeam) : void;
    function userDisconnect(param1:Long) : void;
  }
}
