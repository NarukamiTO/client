package _codec.projects.tanks.client.tanksservices.model.rankloader {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.rankloader.RankInfo;
  import projects.tanks.client.tanksservices.model.rankloader.RankLoaderCC;

  public class CodecRankLoaderCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_ranks:ICodec;

    public function CodecRankLoaderCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_ranks = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(RankInfo,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankLoaderCC = new RankLoaderCC();
      local2.ranks = this.codec_ranks.decode(param1) as Vector.<RankInfo>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankLoaderCC = RankLoaderCC(param2);
      this.codec_ranks.encode(param1,local3.ranks);
    }
  }
}
