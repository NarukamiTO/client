package alternativa.tanks.controllers.battleinfo {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;

  public interface IBattleInfoController extends IEventDispatcher {
    function addFormToStage() : void;
    function removeFormFromStage() : void;
    function hideForm() : void;
    function removeUser(param1:Long) : void;
    function updateBattleName() : void;
    function updateUserScore(param1:Long, param2:int) : void;
    function updateUserSuspiciousState(param1:Long, param2:Boolean) : void;
    function roundStart(param1:int) : void;
    function roundFinish() : void;
    function battleStop() : void;
    function getSelectedBattle() : IGameObject;
  }
}
