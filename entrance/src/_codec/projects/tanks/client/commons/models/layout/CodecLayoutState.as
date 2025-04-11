package _codec.projects.tanks.client.commons.models.layout {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class CodecLayoutState implements ICodec {
    public function CodecLayoutState() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LayoutState = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = LayoutState.MATCHMAKING;
          break;
        case 1:
          local2 = LayoutState.BATTLE_SELECT;
          break;
        case 2:
          local2 = LayoutState.GARAGE;
          break;
        case 3:
          local2 = LayoutState.BATTLE;
          break;
        case 4:
          local2 = LayoutState.RELOAD_SPACE;
          break;
        case 5:
          local2 = LayoutState.CLAN;
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
