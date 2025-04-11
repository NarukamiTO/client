package alternativa.tanks.models.battle.battlefield.event {
  import flash.events.Event;

  public class ContinueBattleEvent extends Event {
    public static const EXIT:String = "BattleStateEvent.EXIT";
    public static const CONTINUE:String = "BattleStateEvent.CONTINUE";

    public function ContinueBattleEvent(param1:String) {
      super(param1);
    }
  }
}
