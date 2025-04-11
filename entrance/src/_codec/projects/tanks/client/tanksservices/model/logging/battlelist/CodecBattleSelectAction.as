package _codec.projects.tanks.client.tanksservices.model.logging.battlelist {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.tanksservices.model.logging.battlelist.BattleSelectAction;

  public class CodecBattleSelectAction implements ICodec {
    public function CodecBattleSelectAction() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleSelectAction = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = BattleSelectAction.SELECT_BATTLE;
          break;
        case 1:
          local2 = BattleSelectAction.CHOOSE_MODE;
          break;
        case 2:
          local2 = BattleSelectAction.CREATE_BATTLE;
          break;
        case 3:
          local2 = BattleSelectAction.ENTER_TO_BATTLE;
          break;
        case 4:
          local2 = BattleSelectAction.COPY_BATTLE_LINK;
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
