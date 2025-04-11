package _codec.projects.tanks.client.battlefield.models.effects.description {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.effects.description.EffectCategory;

  public class CodecEffectCategory implements ICodec {
    public function CodecEffectCategory() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EffectCategory = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = EffectCategory.INVENTORY;
          break;
        case 1:
          local2 = EffectCategory.BONUS;
          break;
        case 2:
          local2 = EffectCategory.OVERDRIVE;
          break;
        case 3:
          local2 = EffectCategory.OTHER;
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
