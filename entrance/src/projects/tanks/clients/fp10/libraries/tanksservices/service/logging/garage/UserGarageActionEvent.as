package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.tanksservices.model.logging.garage.GarageAction;

  public class UserGarageActionEvent extends Event {
    public static const TYPE:String = "UserGarageActionEvent";

    private var _action:GarageAction;
    private var _item:IGameObject;

    public function UserGarageActionEvent(param1:GarageAction, param2:IGameObject) {
      this._action = param1;
      this._item = param2;
      super(TYPE);
    }

    public function getAction() : GarageAction {
      return this._action;
    }

    public function getItem() : IGameObject {
      return this._item;
    }
  }
}
