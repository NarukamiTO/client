package projects.tanks.client.users.services.chatmoderator {
  public class ChatModeratorLevel {
    public static const NONE:ChatModeratorLevel = new ChatModeratorLevel(0,"NONE");
    public static const COMMUNITY_MANAGER:ChatModeratorLevel = new ChatModeratorLevel(1,"COMMUNITY_MANAGER");
    public static const BATTLE_ADMINISTRATOR:ChatModeratorLevel = new ChatModeratorLevel(2,"BATTLE_ADMINISTRATOR");
    public static const BATTLE_MODERATOR:ChatModeratorLevel = new ChatModeratorLevel(3,"BATTLE_MODERATOR");
    public static const BATTLE_CANDIDATE:ChatModeratorLevel = new ChatModeratorLevel(4,"BATTLE_CANDIDATE");
    public static const ADMINISTRATOR:ChatModeratorLevel = new ChatModeratorLevel(5,"ADMINISTRATOR");
    public static const MODERATOR:ChatModeratorLevel = new ChatModeratorLevel(6,"MODERATOR");
    public static const CANDIDATE:ChatModeratorLevel = new ChatModeratorLevel(7,"CANDIDATE");
    public static const EVENT_CHAT_ADMIN:ChatModeratorLevel = new ChatModeratorLevel(8,"EVENT_CHAT_ADMIN");
    public static const EVENT_CHAT_MODERATOR:ChatModeratorLevel = new ChatModeratorLevel(9,"EVENT_CHAT_MODERATOR");
    public static const EVENT_CHAT_CANDIDATE:ChatModeratorLevel = new ChatModeratorLevel(10,"EVENT_CHAT_CANDIDATE");

    private var _value:int;
    private var _name:String;

    public function ChatModeratorLevel(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ChatModeratorLevel> {
      var local1:Vector.<ChatModeratorLevel> = new Vector.<ChatModeratorLevel>();
      local1.push(NONE);
      local1.push(COMMUNITY_MANAGER);
      local1.push(BATTLE_ADMINISTRATOR);
      local1.push(BATTLE_MODERATOR);
      local1.push(BATTLE_CANDIDATE);
      local1.push(ADMINISTRATOR);
      local1.push(MODERATOR);
      local1.push(CANDIDATE);
      local1.push(EVENT_CHAT_ADMIN);
      local1.push(EVENT_CHAT_MODERATOR);
      local1.push(EVENT_CHAT_CANDIDATE);
      return local1;
    }

    public function toString() : String {
      return "ChatModeratorLevel [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
