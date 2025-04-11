package _codec.projects.tanks.client.battleselect.model.matchmaking.queue {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class CodecMatchmakingMode implements ICodec {
    public function CodecMatchmakingMode() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchmakingMode = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = MatchmakingMode.TEAM_MODE;
          break;
        case 1:
          local2 = MatchmakingMode.DM_ONLY;
          break;
        case 2:
          local2 = MatchmakingMode.TDM_ONLY;
          break;
        case 3:
          local2 = MatchmakingMode.CTF_ONLY;
          break;
        case 4:
          local2 = MatchmakingMode.CP_ONLY;
          break;
        case 5:
          local2 = MatchmakingMode.AS_ONLY;
          break;
        case 6:
          local2 = MatchmakingMode.RUGBY_ONLY;
          break;
        case 7:
          local2 = MatchmakingMode.JGR_ONLY;
          break;
        case 8:
          local2 = MatchmakingMode.HOLIDAY;
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
