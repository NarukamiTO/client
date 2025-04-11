package _codec.projects.tanks.client.panel.model.payment.modes.qiwi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;

  public class CodecCountryPhoneInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_code:ICodec;
    private var codec_name:ICodec;
    private var codec_phoneLength:ICodec;

    public function CodecCountryPhoneInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_code = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_phoneLength = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CountryPhoneInfo = new CountryPhoneInfo();
      local2.code = this.codec_code.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.phoneLength = this.codec_phoneLength.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CountryPhoneInfo = CountryPhoneInfo(param2);
      this.codec_code.encode(param1,local3.code);
      this.codec_name.encode(param1,local3.name);
      this.codec_phoneLength.encode(param1,local3.phoneLength);
    }
  }
}
