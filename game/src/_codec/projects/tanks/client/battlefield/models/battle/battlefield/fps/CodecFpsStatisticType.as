package _codec.projects.tanks.client.battlefield.models.battle.battlefield.fps {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.battle.battlefield.fps.FpsStatisticType;

  public class CodecFpsStatisticType implements ICodec {
    public function CodecFpsStatisticType() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FpsStatisticType = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = FpsStatisticType.SOFTWARE;
          break;
        case 1:
          local2 = FpsStatisticType.HARDWARE_CONSTRAINT;
          break;
        case 2:
          local2 = FpsStatisticType.HARDWARE_BASELINE;
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
