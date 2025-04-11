package _codec.projects.tanks.client.garage.models.item.relativeproperties {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.garage.models.item.relativeproperties.RelativeProperties;

  public class CodecRelativeProperties implements ICodec {
    public function CodecRelativeProperties() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RelativeProperties = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = RelativeProperties.ARMOR;
          break;
        case 1:
          local2 = RelativeProperties.SPEED;
          break;
        case 2:
          local2 = RelativeProperties.HANDLING;
          break;
        case 3:
          local2 = RelativeProperties.MASS;
          break;
        case 4:
          local2 = RelativeProperties.SIZE;
          break;
        case 5:
          local2 = RelativeProperties.BURST_DAMAGE;
          break;
        case 6:
          local2 = RelativeProperties.DPS;
          break;
        case 7:
          local2 = RelativeProperties.FIRE_RATE;
          break;
        case 8:
          local2 = RelativeProperties.RANGE;
          break;
        case 9:
          local2 = RelativeProperties.COMPLEXITY;
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
