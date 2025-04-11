package _codec.platform.client.core.general.socialnetwork.models.socialnetworkparameters {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.socialnetwork.models.socialnetworkparameters.SocialNetworkParametersCC;

  public class CodecSocialNetworkParametersCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_hasOwnPaymentSystem:ICodec;
    private var codec_hasSocialFunction:ICodec;

    public function CodecSocialNetworkParametersCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_hasOwnPaymentSystem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasSocialFunction = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SocialNetworkParametersCC = new SocialNetworkParametersCC();
      local2.hasOwnPaymentSystem = this.codec_hasOwnPaymentSystem.decode(param1) as Boolean;
      local2.hasSocialFunction = this.codec_hasSocialFunction.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SocialNetworkParametersCC = SocialNetworkParametersCC(param2);
      this.codec_hasOwnPaymentSystem.encode(param1,local3.hasOwnPaymentSystem);
      this.codec_hasSocialFunction.encode(param1,local3.hasSocialFunction);
    }
  }
}
