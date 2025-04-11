package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.tanksservices.model.logging.battlelist.BattleSelectAction;

  public class UserBattleSelectActionsServiceImpl extends EventDispatcher implements UserBattleSelectActionsService {
    public function UserBattleSelectActionsServiceImpl() {
      super();
    }

    public function battleSelected(param1:BattleMode, param2:Long) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.SELECT_BATTLE,param1,param2.toString()));
    }

    public function turnOnBattleMode(param1:BattleMode) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.CHOOSE_MODE,param1,"ON"));
    }

    public function turnOffBattleMode(param1:BattleMode) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.CHOOSE_MODE,param1,"OFF"));
    }

    public function createBattle(param1:BattleMode) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.CREATE_BATTLE,param1));
    }

    public function enterToBattle(param1:BattleMode, param2:Long) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.ENTER_TO_BATTLE,param1,param2.toString()));
    }

    public function copyBattleLink(param1:BattleMode, param2:Long) : void {
      dispatchEvent(new UserBattleSelectActionEvent(BattleSelectAction.COPY_BATTLE_LINK,param1,param2.toString()));
    }
  }
}
