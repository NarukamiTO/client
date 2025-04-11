package alternativa.tanks.controllers.mainview {
  import flash.events.Event;

  public class SwitchToBattleSelectEvent extends Event {
    public static const EVENT:String = "SHOW_BATTLE_SELECT";

    public function SwitchToBattleSelectEvent() {
      super(EVENT,true);
    }
  }
}
