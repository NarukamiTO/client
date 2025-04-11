package alternativa.tanks.services.battlegui {
  import flash.events.Event;

  public class InventoryChangePositionEvent extends Event {
    public static const ON_CHANGE_POSITION:String = "BattleGUIServiceEvent.ON_CHANGE_POSITION";

    public function InventoryChangePositionEvent() {
      super(ON_CHANGE_POSITION);
    }
  }
}
