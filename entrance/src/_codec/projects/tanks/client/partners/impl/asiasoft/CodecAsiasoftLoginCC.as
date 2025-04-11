package _codec.projects.tanks.client.partners.impl.asiasoft {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.partners.impl.asiasoft.AsiasoftLoginCC;

  public class CodecAsiasoftLoginCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_facebookIcon:ICodec;
    private var codec_googleIcon:ICodec;
    private var codec_initialUrl:ICodec;
    private var codec_playIdIcon:ICodec;

    public function CodecAsiasoftLoginCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_facebookIcon = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_googleIcon = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_initialUrl = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_playIdIcon = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AsiasoftLoginCC = new AsiasoftLoginCC();
      local2.facebookIcon = this.codec_facebookIcon.decode(param1) as ImageResource;
      local2.googleIcon = this.codec_googleIcon.decode(param1) as ImageResource;
      local2.initialUrl = this.codec_initialUrl.decode(param1) as String;
      local2.playIdIcon = this.codec_playIdIcon.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AsiasoftLoginCC = AsiasoftLoginCC(param2);
      this.codec_facebookIcon.encode(param1,local3.facebookIcon);
      this.codec_googleIcon.encode(param1,local3.googleIcon);
      this.codec_initialUrl.encode(param1,local3.initialUrl);
      this.codec_playIdIcon.encode(param1,local3.playIdIcon);
    }
  }
}
