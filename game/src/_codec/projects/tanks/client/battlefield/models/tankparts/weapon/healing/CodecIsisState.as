package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;

  public class CodecIsisState implements ICodec {
    public function CodecIsisState() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:IsisState = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = IsisState.OFF;
          break;
        case 1:
          local2 = IsisState.IDLE;
          break;
        case 2:
          local2 = IsisState.HEALING;
          break;
        case 3:
          local2 = IsisState.DAMAGING;
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
