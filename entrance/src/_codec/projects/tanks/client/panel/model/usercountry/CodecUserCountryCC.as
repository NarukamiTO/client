package _codec.projects.tanks.client.panel.model.usercountry {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;
  import projects.tanks.client.panel.model.usercountry.UserCountryCC;

  public class CodecUserCountryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_countries:ICodec;
    private var codec_defaultCountryCode:ICodec;
    private var codec_locationCheckEnabled:ICodec;

    public function CodecUserCountryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_countries = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(CountryInfo,false),false,1));
      this.codec_defaultCountryCode = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_locationCheckEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserCountryCC = new UserCountryCC();
      local2.countries = this.codec_countries.decode(param1) as Vector.<CountryInfo>;
      local2.defaultCountryCode = this.codec_defaultCountryCode.decode(param1) as String;
      local2.locationCheckEnabled = this.codec_locationCheckEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserCountryCC = UserCountryCC(param2);
      this.codec_countries.encode(param1,local3.countries);
      this.codec_defaultCountryCode.encode(param1,local3.defaultCountryCode);
      this.codec_locationCheckEnabled.encode(param1,local3.locationCheckEnabled);
    }
  }
}
