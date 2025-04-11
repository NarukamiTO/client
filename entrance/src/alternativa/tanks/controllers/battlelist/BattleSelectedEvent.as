package alternativa.tanks.controllers.battlelist {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleSelectedEvent extends Event {
    public static const BATTLE_SELECTED:String = "BattleListControllerEvent.BATTLE_SELECTED";

    public var selectedItem:IGameObject;

    public function BattleSelectedEvent(param1:String, param2:IGameObject) {
      super(param1);
      this.selectedItem = param2;
    }
  }
}
