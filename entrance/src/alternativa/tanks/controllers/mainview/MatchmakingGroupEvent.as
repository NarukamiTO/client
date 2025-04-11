package alternativa.tanks.controllers.mainview {
  import flash.events.Event;

  public class MatchmakingGroupEvent extends Event {
    public static const CREATE:String = "MatchmakingGroupEvent.CREATE";
    public static const LEAVE:String = "MatchmakingGroupEvent.LEAVE";

    public function MatchmakingGroupEvent(param1:String) {
      super(param1);
    }

    override public function clone() : Event {
      return new MatchmakingGroupEvent(type);
    }
  }
}
