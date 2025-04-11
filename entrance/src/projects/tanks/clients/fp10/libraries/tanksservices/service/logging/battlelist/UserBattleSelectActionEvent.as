package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist {
  import flash.events.Event;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.tanksservices.model.logging.battlelist.BattleSelectAction;

  public class UserBattleSelectActionEvent extends Event {
    public static const TYPE:String = "UserBattleSelectActionEvent";

    private var _action:BattleSelectAction;
    private var _mode:BattleMode;
    private var _additionalInfo:String;

    public function UserBattleSelectActionEvent(param1:BattleSelectAction, param2:BattleMode, param3:String = null) {
      this._action = param1;
      this._mode = param2;
      this._additionalInfo = param3;
      super(TYPE);
    }

    public function getAction() : BattleSelectAction {
      return this._action;
    }

    public function getMode() : BattleMode {
      return this._mode;
    }

    public function getAdditionalInfo() : String {
      return this._additionalInfo;
    }
  }
}
