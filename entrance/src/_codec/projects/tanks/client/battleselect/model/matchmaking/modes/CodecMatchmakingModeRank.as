package _codec.projects.tanks.client.battleselect.model.matchmaking.modes {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.matchmaking.modes.MatchmakingModeRank;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public class CodecMatchmakingModeRank implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_matchmakingMode:ICodec;
    private var codec_rank:ICodec;

    public function CodecMatchmakingModeRank() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_matchmakingMode = param1.getCodec(new EnumCodecInfo(MatchmakingMode,false));
      this.codec_rank = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchmakingModeRank = new MatchmakingModeRank();
      local2.matchmakingMode = this.codec_matchmakingMode.decode(param1) as MatchmakingMode;
      local2.rank = this.codec_rank.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MatchmakingModeRank = MatchmakingModeRank(param2);
      this.codec_matchmakingMode.encode(param1,local3.matchmakingMode);
      this.codec_rank.encode(param1,local3.rank);
    }
  }
}
