package _codec.projects.tanks.client.users.services.chatmoderator {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class CodecChatModeratorLevel implements ICodec {
    public function CodecChatModeratorLevel() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChatModeratorLevel = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ChatModeratorLevel.NONE;
          break;
        case 1:
          local2 = ChatModeratorLevel.COMMUNITY_MANAGER;
          break;
        case 2:
          local2 = ChatModeratorLevel.BATTLE_ADMINISTRATOR;
          break;
        case 3:
          local2 = ChatModeratorLevel.BATTLE_MODERATOR;
          break;
        case 4:
          local2 = ChatModeratorLevel.BATTLE_CANDIDATE;
          break;
        case 5:
          local2 = ChatModeratorLevel.ADMINISTRATOR;
          break;
        case 6:
          local2 = ChatModeratorLevel.MODERATOR;
          break;
        case 7:
          local2 = ChatModeratorLevel.CANDIDATE;
          break;
        case 8:
          local2 = ChatModeratorLevel.EVENT_CHAT_ADMIN;
          break;
        case 9:
          local2 = ChatModeratorLevel.EVENT_CHAT_MODERATOR;
          break;
        case 10:
          local2 = ChatModeratorLevel.EVENT_CHAT_CANDIDATE;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
