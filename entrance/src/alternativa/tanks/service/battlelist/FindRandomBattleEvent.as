package alternativa.tanks.service.battlelist {
  import flash.events.Event;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class FindRandomBattleEvent extends Event {
    public static const EVENT:String = "FindRandomBattleEvent.EVENT";

    private var mode:MatchmakingMode;

    public function FindRandomBattleEvent(param1:MatchmakingMode) {
      super(EVENT);
      this.mode = param1;
    }

    public function getMode() : MatchmakingMode {
      return this.mode;
    }
  }
}
