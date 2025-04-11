package _codec.projects.tanks.client.battlefield.models.bonus.bonus {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;

  public class CodecBonusesType implements ICodec {
    public function CodecBonusesType() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusesType = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = BonusesType.CRYSTAL;
          break;
        case 1:
          local2 = BonusesType.NITRO;
          break;
        case 2:
          local2 = BonusesType.ARMOR_UP;
          break;
        case 3:
          local2 = BonusesType.FIRST_AID;
          break;
        case 4:
          local2 = BonusesType.DAMAGE_UP;
          break;
        case 5:
          local2 = BonusesType.RECHARGE;
          break;
        case 6:
          local2 = BonusesType.GOLD;
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
