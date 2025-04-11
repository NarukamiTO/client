package _codec.projects.tanks.client.clans.license.user {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.license.user.LicenseClanUserCC;

  public class CodecLicenseClanUserCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_clanLicense:ICodec;
    private var codec_licenseGarageObject:ICodec;

    public function CodecLicenseClanUserCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_clanLicense = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_licenseGarageObject = param1.getCodec(new TypeCodecInfo(IGameObject,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LicenseClanUserCC = new LicenseClanUserCC();
      local2.clanLicense = this.codec_clanLicense.decode(param1) as Boolean;
      local2.licenseGarageObject = this.codec_licenseGarageObject.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LicenseClanUserCC = LicenseClanUserCC(param2);
      this.codec_clanLicense.encode(param1,local3.clanLicense);
      this.codec_licenseGarageObject.encode(param1,local3.licenseGarageObject);
    }
  }
}
