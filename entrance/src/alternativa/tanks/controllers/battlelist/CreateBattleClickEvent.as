package alternativa.tanks.controllers.battlelist {
  import flash.events.Event;

  public class CreateBattleClickEvent extends Event {
    public static const CREATE_BATTLE_CLICK:String = "CreateBattleClickEvent.CREATE_BATTLE_CLICK";

    public function CreateBattleClickEvent() {
      super(CREATE_BATTLE_CLICK);
    }
  }
}
