package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.gauss {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;

  public class CodecGaussCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_aimedShotImpact:ICodec;
    private var codec_aimedShotKickback:ICodec;
    private var codec_aimingGracePeriod:ICodec;
    private var codec_aimingTime:ICodec;
    private var codec_powerShotReloadDurationMs:ICodec;
    private var codec_primaryShellRadius:ICodec;
    private var codec_primaryShellSpeed:ICodec;
    private var codec_secondarySplashParams:ICodec;
    private var codec_shotRange:ICodec;

    public function CodecGaussCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_aimedShotImpact = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_aimedShotKickback = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_aimingGracePeriod = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_aimingTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_powerShotReloadDurationMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_primaryShellRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_primaryShellSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_secondarySplashParams = param1.getCodec(new TypeCodecInfo(SplashCC,false));
      this.codec_shotRange = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GaussCC = new GaussCC();
      local2.aimedShotImpact = this.codec_aimedShotImpact.decode(param1) as Number;
      local2.aimedShotKickback = this.codec_aimedShotKickback.decode(param1) as Number;
      local2.aimingGracePeriod = this.codec_aimingGracePeriod.decode(param1) as int;
      local2.aimingTime = this.codec_aimingTime.decode(param1) as int;
      local2.powerShotReloadDurationMs = this.codec_powerShotReloadDurationMs.decode(param1) as int;
      local2.primaryShellRadius = this.codec_primaryShellRadius.decode(param1) as Number;
      local2.primaryShellSpeed = this.codec_primaryShellSpeed.decode(param1) as Number;
      local2.secondarySplashParams = this.codec_secondarySplashParams.decode(param1) as SplashCC;
      local2.shotRange = this.codec_shotRange.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GaussCC = GaussCC(param2);
      this.codec_aimedShotImpact.encode(param1,local3.aimedShotImpact);
      this.codec_aimedShotKickback.encode(param1,local3.aimedShotKickback);
      this.codec_aimingGracePeriod.encode(param1,local3.aimingGracePeriod);
      this.codec_aimingTime.encode(param1,local3.aimingTime);
      this.codec_powerShotReloadDurationMs.encode(param1,local3.powerShotReloadDurationMs);
      this.codec_primaryShellRadius.encode(param1,local3.primaryShellRadius);
      this.codec_primaryShellSpeed.encode(param1,local3.primaryShellSpeed);
      this.codec_secondarySplashParams.encode(param1,local3.secondarySplashParams);
      this.codec_shotRange.encode(param1,local3.shotRange);
    }
  }
}
