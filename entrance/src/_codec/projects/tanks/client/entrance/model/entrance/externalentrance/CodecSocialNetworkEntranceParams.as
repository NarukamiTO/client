package _codec.projects.tanks.client.entrance.model.entrance.externalentrance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;

  public class CodecSocialNetworkEntranceParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_authorizationUrl:ICodec;
    private var codec_enabled:ICodec;
    private var codec_snId:ICodec;

    public function CodecSocialNetworkEntranceParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_authorizationUrl = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,true));
      this.codec_snId = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SocialNetworkEntranceParams = new SocialNetworkEntranceParams();
      local2.authorizationUrl = this.codec_authorizationUrl.decode(param1) as String;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      local2.snId = this.codec_snId.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SocialNetworkEntranceParams = SocialNetworkEntranceParams(param2);
      this.codec_authorizationUrl.encode(param1,local3.authorizationUrl);
      this.codec_enabled.encode(param1,local3.enabled);
      this.codec_snId.encode(param1,local3.snId);
    }
  }
}
