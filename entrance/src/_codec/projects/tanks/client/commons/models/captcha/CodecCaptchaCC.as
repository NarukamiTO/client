package _codec.projects.tanks.client.commons.models.captcha {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.commons.models.captcha.CaptchaCC;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class CodecCaptchaCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_stateWithCaptcha:ICodec;

    public function CodecCaptchaCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_stateWithCaptcha = param1.getCodec(new CollectionCodecInfo(new EnumCodecInfo(CaptchaLocation,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CaptchaCC = new CaptchaCC();
      local2.stateWithCaptcha = this.codec_stateWithCaptcha.decode(param1) as Vector.<CaptchaLocation>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CaptchaCC = CaptchaCC(param2);
      this.codec_stateWithCaptcha.encode(param1,local3.stateWithCaptcha);
    }
  }
}
