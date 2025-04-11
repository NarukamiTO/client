package _codec.projects.tanks.client.panel.model.shop.emailrequired {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.emailrequired.EmailRequiredCC;

  public class CodecEmailRequiredCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_emailRequired:ICodec;

    public function CodecEmailRequiredCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_emailRequired = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EmailRequiredCC = new EmailRequiredCC();
      local2.emailRequired = this.codec_emailRequired.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EmailRequiredCC = EmailRequiredCC(param2);
      this.codec_emailRequired.encode(param1,local3.emailRequired);
    }
  }
}
