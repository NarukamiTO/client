package _codec.projects.tanks.client.chat.models.chat.chat {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;

  public class CodecChatAddressMode implements ICodec {
    public function CodecChatAddressMode() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChatAddressMode = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ChatAddressMode.PUBLIC_TO_ALL;
          break;
        case 1:
          local2 = ChatAddressMode.PUBLIC_ADDRESSED;
          break;
        case 2:
          local2 = ChatAddressMode.PRIVATE;
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
