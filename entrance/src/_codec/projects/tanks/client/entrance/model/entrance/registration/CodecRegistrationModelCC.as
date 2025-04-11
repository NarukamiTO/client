package _codec.projects.tanks.client.entrance.model.entrance.registration {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelCC;

  public class CodecRegistrationModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bgResource:ICodec;
    private var codec_enableRequiredEmail:ICodec;
    private var codec_maxPasswordLength:ICodec;
    private var codec_minPasswordLength:ICodec;

    public function CodecRegistrationModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bgResource = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_enableRequiredEmail = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_maxPasswordLength = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_minPasswordLength = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RegistrationModelCC = new RegistrationModelCC();
      local2.bgResource = this.codec_bgResource.decode(param1) as ImageResource;
      local2.enableRequiredEmail = this.codec_enableRequiredEmail.decode(param1) as Boolean;
      local2.maxPasswordLength = this.codec_maxPasswordLength.decode(param1) as int;
      local2.minPasswordLength = this.codec_minPasswordLength.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RegistrationModelCC = RegistrationModelCC(param2);
      this.codec_bgResource.encode(param1,local3.bgResource);
      this.codec_enableRequiredEmail.encode(param1,local3.enableRequiredEmail);
      this.codec_maxPasswordLength.encode(param1,local3.maxPasswordLength);
      this.codec_minPasswordLength.encode(param1,local3.minPasswordLength);
    }
  }
}
