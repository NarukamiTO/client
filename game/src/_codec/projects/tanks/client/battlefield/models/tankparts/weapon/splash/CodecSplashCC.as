package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.splash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;

  public class CodecSplashCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_impactForce:ICodec;
    private var codec_minSplashDamagePercent:ICodec;
    private var codec_radiusOfMaxSplashDamage:ICodec;
    private var codec_splashDamageRadius:ICodec;

    public function CodecSplashCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_impactForce = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minSplashDamagePercent = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_radiusOfMaxSplashDamage = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_splashDamageRadius = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SplashCC = new SplashCC();
      local2.impactForce = this.codec_impactForce.decode(param1) as Number;
      local2.minSplashDamagePercent = this.codec_minSplashDamagePercent.decode(param1) as Number;
      local2.radiusOfMaxSplashDamage = this.codec_radiusOfMaxSplashDamage.decode(param1) as Number;
      local2.splashDamageRadius = this.codec_splashDamageRadius.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SplashCC = SplashCC(param2);
      this.codec_impactForce.encode(param1,local3.impactForce);
      this.codec_minSplashDamagePercent.encode(param1,local3.minSplashDamagePercent);
      this.codec_radiusOfMaxSplashDamage.encode(param1,local3.radiusOfMaxSplashDamage);
      this.codec_splashDamageRadius.encode(param1,local3.splashDamageRadius);
    }
  }
}
