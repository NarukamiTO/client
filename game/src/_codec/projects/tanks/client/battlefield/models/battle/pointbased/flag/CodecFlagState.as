package _codec.projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;

  public class CodecFlagState implements ICodec {
    public function CodecFlagState() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FlagState = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = FlagState.AT_BASE;
          break;
        case 1:
          local2 = FlagState.DROPPED;
          break;
        case 2:
          local2 = FlagState.CARRIED;
          break;
        case 3:
          local2 = FlagState.EXILED;
          break;
        case 4:
          local2 = FlagState.FLYING;
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
