package _codec.projects.tanks.client.users.model.userbattlestatistics.rank {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;

  public class CodecRankBounds implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_lowBound:ICodec;
    private var codec_topBound:ICodec;

    public function CodecRankBounds() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_lowBound = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_topBound = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankBounds = new RankBounds();
      local2.lowBound = this.codec_lowBound.decode(param1) as int;
      local2.topBound = this.codec_topBound.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankBounds = RankBounds(param2);
      this.codec_lowBound.encode(param1,local3.lowBound);
      this.codec_topBound.encode(param1,local3.topBound);
    }
  }
}
