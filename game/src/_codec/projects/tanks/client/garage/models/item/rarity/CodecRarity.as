package _codec.projects.tanks.client.garage.models.item.rarity {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.garage.models.item.rarity.Rarity;

  public class CodecRarity implements ICodec {
    public function CodecRarity() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Rarity = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = Rarity.CUSTOMISE;
          break;
        case 1:
          local2 = Rarity.LEGENDARY;
          break;
        case 2:
          local2 = Rarity.EPIC;
          break;
        case 3:
          local2 = Rarity.RARE;
          break;
        case 4:
          local2 = Rarity.CASUAL;
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
