package _codec.projects.tanks.client.tanksservices.model.rankloader {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.rankloader.RankInfo;

  public class CodecRankInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_index:ICodec;
    private var codec_name:ICodec;

    public function CodecRankInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_index = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankInfo = new RankInfo();
      local2.index = this.codec_index.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankInfo = RankInfo(param2);
      this.codec_index.encode(param1,local3.index);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
