package alternativa.tanks.controllers.battleinfo {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.type.IGameObject;

  public class EmptyBattleInfoController extends EventDispatcher implements IBattleInfoController {
    public function EmptyBattleInfoController() {
      super();
    }

    public function addFormToStage() : void {
    }

    public function removeFormFromStage() : void {
    }

    public function hideForm() : void {
    }

    public function removeUser(param1:Long) : void {
    }

    public function updateUserScore(param1:Long, param2:int) : void {
    }

    public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
    }

    public function roundStart(param1:int) : void {
    }

    public function roundFinish() : void {
    }

    public function battleStop() : void {
    }

    public function getSelectedBattle() : IGameObject {
      return null;
    }

    public function updateBattleName() : void {
    }
  }
}
