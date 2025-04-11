package _codec.projects.tanks.client.panel.model.usercountry {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;

  public class CodecCountryInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_countryCode:ICodec;
    private var codec_countryName:ICodec;

    public function CodecCountryInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_countryCode = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_countryName = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CountryInfo = new CountryInfo();
      local2.countryCode = this.codec_countryCode.decode(param1) as String;
      local2.countryName = this.codec_countryName.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CountryInfo = CountryInfo(param2);
      this.codec_countryCode.encode(param1,local3.countryCode);
      this.codec_countryName.encode(param1,local3.countryName);
    }
  }
}
