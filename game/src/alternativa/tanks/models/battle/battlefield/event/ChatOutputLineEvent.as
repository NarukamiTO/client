package alternativa.tanks.models.battle.battlefield.event {
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import flash.events.Event;

  public class ChatOutputLineEvent extends Event {
    public static const KILL_ME:String = "KillMe";
    public static const UPDATE_UID:String = "updateUid";

    private var _line:MessageLine;

    public function ChatOutputLineEvent(param1:String, param2:MessageLine) {
      super(param1,false,false);
      this._line = param2;
    }

    public function get line() : MessageLine {
      return this._line;
    }
  }
}
