package alternativa.tanks.service.battlelist {
  import flash.events.Event;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class MatchmakingEvent extends Event {
    public static const REGISTRATION:String = "MatchmakingEvent.REGISTRATION";
    public static const UNREGISTRATION:String = "MatchmakingEvent.UNREGISTRATION";
    public static const ENTER_AS_SPECTATOR:String = "MatchmakingEvent.SPECTATOR";

    private var mode:MatchmakingMode = MatchmakingMode.TEAM_MODE;

    public function MatchmakingEvent(param1:String, param2:MatchmakingMode = null) {
      this.mode = param2;
      super(param1,true);
    }

    public function getMode() : MatchmakingMode {
      return this.mode;
    }

    override public function clone() : Event {
      return new MatchmakingEvent(type,this.mode);
    }
  }
}
