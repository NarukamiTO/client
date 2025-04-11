package _codec.projects.tanks.client.battleservice {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battleservice.BattleMode;

  public class CodecBattleMode implements ICodec {
    public function CodecBattleMode() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleMode = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = BattleMode.DM;
          break;
        case 1:
          local2 = BattleMode.TDM;
          break;
        case 2:
          local2 = BattleMode.CTF;
          break;
        case 3:
          local2 = BattleMode.CP;
          break;
        case 4:
          local2 = BattleMode.AS;
          break;
        case 5:
          local2 = BattleMode.RUGBY;
          break;
        case 6:
          local2 = BattleMode.SUR;
          break;
        case 7:
          local2 = BattleMode.JGR;
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
