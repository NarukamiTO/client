package _codec.projects.tanks.client.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class CodecShopCategoryEnum implements ICodec {
    public function CodecShopCategoryEnum() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopCategoryEnum = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ShopCategoryEnum.CRYSTALS;
          break;
        case 1:
          local2 = ShopCategoryEnum.COINS;
          break;
        case 2:
          local2 = ShopCategoryEnum.PREMIUM;
          break;
        case 3:
          local2 = ShopCategoryEnum.GOLD_BOXES;
          break;
        case 4:
          local2 = ShopCategoryEnum.PAINTS;
          break;
        case 5:
          local2 = ShopCategoryEnum.KITS;
          break;
        case 6:
          local2 = ShopCategoryEnum.OTHERS;
          break;
        case 7:
          local2 = ShopCategoryEnum.LOOT_BOXES;
          break;
        case 8:
          local2 = ShopCategoryEnum.NO_CATEGORY;
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
