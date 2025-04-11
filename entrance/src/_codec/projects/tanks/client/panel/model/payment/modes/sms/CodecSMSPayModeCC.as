package _codec.projects.tanks.client.panel.model.payment.modes.sms {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.sms.SMSPayModeCC;
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;

  public class CodecSMSPayModeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_countries:ICodec;

    public function CodecSMSPayModeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_countries = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Country,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SMSPayModeCC = new SMSPayModeCC();
      local2.countries = this.codec_countries.decode(param1) as Vector.<Country>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SMSPayModeCC = SMSPayModeCC(param2);
      this.codec_countries.encode(param1,local3.countries);
    }
  }
}
