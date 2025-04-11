package alternativa.tanks.service.battleinfo {
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDmParams;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface IBattleInfoFormService extends IEventDispatcher {
    function showDmForm(param1:BattleInfoDmParams) : void;
    function showTeamForm(param1:BattleInfoTeamParams) : void;
    function hideForms() : void;
    function hideBattleForms() : void;
    function destroy() : void;
    function updateTeamScore(param1:BattleTeam, param2:int) : void;
    function removeUser(param1:Long) : void;
    function updateUserScore(param1:Long, param2:int) : void;
    function updateUserSuspiciousState(param1:Long, param2:Boolean) : void;
    function swapTeams() : void;
    function roundStart(param1:int) : void;
    function roundFinish() : void;
    function battleStop() : void;
    function showLastShowedForm() : void;
    function removeFormFromStage() : void;
    function getSelectedBattle() : IGameObject;
    function updateBattleName() : void;
    function addUser(param1:BattleInfoUser, param2:BattleTeam = null) : void;
  }
}
