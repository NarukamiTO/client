package _codec.projects.tanks.client.panel.model.socialnetwork {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelCC;
  import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelParams;

  public class CodecSocialNetworkPanelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_passwordCreated:ICodec;
    private var codec_socialNetworkParams:ICodec;

    public function CodecSocialNetworkPanelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_passwordCreated = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_socialNetworkParams = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkPanelParams,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SocialNetworkPanelCC = new SocialNetworkPanelCC();
      local2.passwordCreated = this.codec_passwordCreated.decode(param1) as Boolean;
      local2.socialNetworkParams = this.codec_socialNetworkParams.decode(param1) as Vector.<SocialNetworkPanelParams>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SocialNetworkPanelCC = SocialNetworkPanelCC(param2);
      this.codec_passwordCreated.encode(param1,local3.passwordCreated);
      this.codec_socialNetworkParams.encode(param1,local3.socialNetworkParams);
    }
  }
}
