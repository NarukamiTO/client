package _codec.projects.tanks.client.panel.model.videoads.containers {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.videoads.containers.VideoAdsMobileLootBoxCC;

  public class CodecVideoAdsMobileLootBoxCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_adsAvailable:ICodec;

    public function CodecVideoAdsMobileLootBoxCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_adsAvailable = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:VideoAdsMobileLootBoxCC = new VideoAdsMobileLootBoxCC();
      local2.adsAvailable = this.codec_adsAvailable.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:VideoAdsMobileLootBoxCC = VideoAdsMobileLootBoxCC(param2);
      this.codec_adsAvailable.encode(param1,local3.adsAvailable);
    }
  }
}
