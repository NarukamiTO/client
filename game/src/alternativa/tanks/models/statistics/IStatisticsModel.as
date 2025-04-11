package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInterface]
  public interface IStatisticsModel {
    function getBattleName() : String;
    function userConnect(param1:ShortUserInfo) : void;
    function userDisconnect(param1:ShortUserInfo) : void;
    function updateUserKills(param1:Long, param2:int) : void;
    function changeTeamScore(param1:BattleTeam, param2:int) : void;
    function turnOnTimerToRestoreBalance(param1:int) : void;
    function turnOffTimerToRestoreBalance() : void;
    function notifyAboutTraining(param1:int) : void;
    function notifyAboutBattle(param1:int) : void;
    function getTimeLeftInSec() : int;
  }
}
