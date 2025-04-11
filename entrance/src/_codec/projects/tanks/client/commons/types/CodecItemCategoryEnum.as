package _codec.projects.tanks.client.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class CodecItemCategoryEnum implements ICodec {
    public function CodecItemCategoryEnum() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemCategoryEnum = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ItemCategoryEnum.WEAPON;
          break;
        case 1:
          local2 = ItemCategoryEnum.ARMOR;
          break;
        case 2:
          local2 = ItemCategoryEnum.PAINT;
          break;
        case 3:
          local2 = ItemCategoryEnum.INVENTORY;
          break;
        case 4:
          local2 = ItemCategoryEnum.PLUGIN;
          break;
        case 5:
          local2 = ItemCategoryEnum.KIT;
          break;
        case 6:
          local2 = ItemCategoryEnum.EMBLEM;
          break;
        case 7:
          local2 = ItemCategoryEnum.CRYSTAL;
          break;
        case 8:
          local2 = ItemCategoryEnum.PRESENT;
          break;
        case 9:
          local2 = ItemCategoryEnum.GIVEN_PRESENT;
          break;
        case 10:
          local2 = ItemCategoryEnum.RESISTANCE_MODULE;
          break;
        case 11:
          local2 = ItemCategoryEnum.DEVICE;
          break;
        case 12:
          local2 = ItemCategoryEnum.LICENSE;
          break;
        case 13:
          local2 = ItemCategoryEnum.CONTAINER;
          break;
        case 14:
          local2 = ItemCategoryEnum.DRONE;
          break;
        case 15:
          local2 = ItemCategoryEnum.SKIN;
          break;
        case 16:
          local2 = ItemCategoryEnum.MOBILE_LOOT_BOX;
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
