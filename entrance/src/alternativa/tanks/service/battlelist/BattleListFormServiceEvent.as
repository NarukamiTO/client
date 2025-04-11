package alternativa.tanks.service.battlelist {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleListFormServiceEvent extends Event {
    public static const BATTLE_SELECTED:String = "BattleListFormServiceEvent.BATTLE_SELECTED";
    public static const BATTLE_UNSELECTED:String = "BattleListFormServiceEvent.BATTLE_UNSELECTED";

    public var selectedItem:IGameObject;

    public function BattleListFormServiceEvent(param1:String, param2:IGameObject = null) {
      super(param1);
      this.selectedItem = param2;
    }
  }
}
