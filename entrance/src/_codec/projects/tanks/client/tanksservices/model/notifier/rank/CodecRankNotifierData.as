package _codec.projects.tanks.client.tanksservices.model.notifier.rank {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;

  public class CodecRankNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_rank:ICodec;
    private var codec_userId:ICodec;

    public function CodecRankNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_rank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankNotifierData = new RankNotifierData();
      local2.rank = this.codec_rank.decode(param1) as int;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankNotifierData = RankNotifierData(param2);
      this.codec_rank.encode(param1,local3.rank);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
