package _codec.projects.tanks.client.entrance.model.entrance.partners {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.partners.CompositePartnerCC;

  public class CodecCompositePartnerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_forceSocialNetwork:ICodec;

    public function CodecCompositePartnerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_forceSocialNetwork = param1.getCodec(new TypeCodecInfo(String,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CompositePartnerCC = new CompositePartnerCC();
      local2.forceSocialNetwork = this.codec_forceSocialNetwork.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CompositePartnerCC = CompositePartnerCC(param2);
      this.codec_forceSocialNetwork.encode(param1,local3.forceSocialNetwork);
    }
  }
}
