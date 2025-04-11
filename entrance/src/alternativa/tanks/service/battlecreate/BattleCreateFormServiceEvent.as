package alternativa.tanks.service.battlecreate {
  import flash.events.Event;

  public class BattleCreateFormServiceEvent extends Event {
    public static const SHOW_FORM:String = "BattleCreateFormServiceEvent.SHOW_FORM";
    public static const HIDE_FORM:String = "BattleCreateFormServiceEvent.HIDE_FORM";

    public function BattleCreateFormServiceEvent(param1:String) {
      super(param1);
    }
  }
}
