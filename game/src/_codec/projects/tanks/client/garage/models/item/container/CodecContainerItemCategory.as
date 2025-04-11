package _codec.projects.tanks.client.garage.models.item.container {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.garage.models.item.container.ContainerItemCategory;

  public class CodecContainerItemCategory implements ICodec {
    public function CodecContainerItemCategory() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ContainerItemCategory = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ContainerItemCategory.COMMON;
          break;
        case 1:
          local2 = ContainerItemCategory.UNCOMMON;
          break;
        case 2:
          local2 = ContainerItemCategory.RARE;
          break;
        case 3:
          local2 = ContainerItemCategory.EPIC;
          break;
        case 4:
          local2 = ContainerItemCategory.LEGENDARY;
          break;
        case 5:
          local2 = ContainerItemCategory.EXOTIC;
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
