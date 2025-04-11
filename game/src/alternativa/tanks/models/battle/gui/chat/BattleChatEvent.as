package alternativa.tanks.models.battle.gui.chat {
  import flash.events.Event;

  public class BattleChatEvent extends Event {
    public static const SEND_MESSAGE:String = "sendMessage";

    private var _message:String;
    private var _teamOnly:Boolean;

    public function BattleChatEvent(param1:String, param2:String, param3:Boolean) {
      super(param1);
      this._message = param2;
      this._teamOnly = param3;
    }

    public function get message() : String {
      return this._message;
    }

    public function get teamOnly() : Boolean {
      return this._teamOnly;
    }

    [Obfuscation(rename="false")]
    override public function clone() : Event {
      return new BattleChatEvent(type,this._message,this._teamOnly);
    }

    [Obfuscation(rename="false")]
    override public function toString() : String {
      return "[BattleChatEvent type=" + type + ", message=" + this._message + ", teamOnly=" + this._teamOnly + "]";
    }
  }
}
