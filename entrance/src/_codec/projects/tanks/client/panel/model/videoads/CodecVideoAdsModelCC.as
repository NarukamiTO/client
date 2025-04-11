package _codec.projects.tanks.client.panel.model.videoads {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.videoads.VideoAdsModelCC;

  public class CodecVideoAdsModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_enable:ICodec;

    public function CodecVideoAdsModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_enable = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:VideoAdsModelCC = new VideoAdsModelCC();
      local2.enable = this.codec_enable.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:VideoAdsModelCC = VideoAdsModelCC(param2);
      this.codec_enable.encode(param1,local3.enable);
    }
  }
}
