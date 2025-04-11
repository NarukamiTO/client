package _codec.projects.tanks.client.panel.model.payment.modes.qiwi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;
  import projects.tanks.client.panel.model.payment.modes.qiwi.QiwiPaymentCC;

  public class CodecQiwiPaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_countryPhoneCodes:ICodec;

    public function CodecQiwiPaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_countryPhoneCodes = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(CountryPhoneInfo,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:QiwiPaymentCC = new QiwiPaymentCC();
      local2.countryPhoneCodes = this.codec_countryPhoneCodes.decode(param1) as Vector.<CountryPhoneInfo>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:QiwiPaymentCC = QiwiPaymentCC(param2);
      this.codec_countryPhoneCodes.encode(param1,local3.countryPhoneCodes);
    }
  }
}
