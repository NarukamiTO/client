package _codec.projects.tanks.client.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.types.ShopAbonementBonusTypeEnum;

  public class CodecShopAbonementBonusTypeEnum implements ICodec {
    public function CodecShopAbonementBonusTypeEnum() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopAbonementBonusTypeEnum = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ShopAbonementBonusTypeEnum.BONUS;
          break;
        case 1:
          local2 = ShopAbonementBonusTypeEnum.DISCOUNT;
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
