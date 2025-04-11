package _codec.projects.tanks.client.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class CodecItemViewCategoryEnum implements ICodec {
    public function CodecItemViewCategoryEnum() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemViewCategoryEnum = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ItemViewCategoryEnum.WEAPON;
          break;
        case 1:
          local2 = ItemViewCategoryEnum.ARMOR;
          break;
        case 2:
          local2 = ItemViewCategoryEnum.PAINT;
          break;
        case 3:
          local2 = ItemViewCategoryEnum.INVENTORY;
          break;
        case 4:
          local2 = ItemViewCategoryEnum.KIT;
          break;
        case 5:
          local2 = ItemViewCategoryEnum.SPECIAL;
          break;
        case 6:
          local2 = ItemViewCategoryEnum.GIVEN_PRESENTS;
          break;
        case 7:
          local2 = ItemViewCategoryEnum.RESISTANCE;
          break;
        case 8:
          local2 = ItemViewCategoryEnum.DRONE;
          break;
        case 9:
          local2 = ItemViewCategoryEnum.INVISIBLE;
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
