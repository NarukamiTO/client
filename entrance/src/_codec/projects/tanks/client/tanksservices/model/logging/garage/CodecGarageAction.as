package _codec.projects.tanks.client.tanksservices.model.logging.garage {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.tanksservices.model.logging.garage.GarageAction;

  public class CodecGarageAction implements ICodec {
    public function CodecGarageAction() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GarageAction = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = GarageAction.SELECT_ITEM;
          break;
        case 1:
          local2 = GarageAction.EQUIP_ITEM;
          break;
        case 2:
          local2 = GarageAction.UNMOUNT_ITEM;
          break;
        case 3:
          local2 = GarageAction.BUY_ITEM;
          break;
        case 4:
          local2 = GarageAction.BUY_MODIFICATION;
          break;
        case 5:
          local2 = GarageAction.UPGRADE_ITEM;
          break;
        case 6:
          local2 = GarageAction.CHOOSE_COUNT;
          break;
        case 7:
          local2 = GarageAction.SHOW_BUY_CRYSTALS_WINDOW;
          break;
        case 8:
          local2 = GarageAction.PURCHASE_ACCEPTED;
          break;
        case 9:
          local2 = GarageAction.PURCHASE_DECLINED;
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
