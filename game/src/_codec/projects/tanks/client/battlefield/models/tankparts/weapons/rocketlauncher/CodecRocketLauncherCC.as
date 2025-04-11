package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;

  public class CodecRocketLauncherCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_angularVelocity:ICodec;
    private var codec_boostPhaseDuration:ICodec;
    private var codec_maxSpeed:ICodec;
    private var codec_minSpeed:ICodec;
    private var codec_salvoAimingGracePeriod:ICodec;
    private var codec_salvoAimingTime:ICodec;
    private var codec_salvoReloadTime:ICodec;
    private var codec_salvoSize:ICodec;
    private var codec_shellRadius:ICodec;
    private var codec_shotRange:ICodec;
    private var codec_timeBetweenShotsOfSalvo:ICodec;

    public function CodecRocketLauncherCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_angularVelocity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_boostPhaseDuration = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_maxSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_salvoAimingGracePeriod = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_salvoAimingTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_salvoReloadTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_salvoSize = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_shellRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shotRange = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_timeBetweenShotsOfSalvo = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RocketLauncherCC = new RocketLauncherCC();
      local2.angularVelocity = this.codec_angularVelocity.decode(param1) as Number;
      local2.boostPhaseDuration = this.codec_boostPhaseDuration.decode(param1) as int;
      local2.maxSpeed = this.codec_maxSpeed.decode(param1) as Number;
      local2.minSpeed = this.codec_minSpeed.decode(param1) as Number;
      local2.salvoAimingGracePeriod = this.codec_salvoAimingGracePeriod.decode(param1) as int;
      local2.salvoAimingTime = this.codec_salvoAimingTime.decode(param1) as int;
      local2.salvoReloadTime = this.codec_salvoReloadTime.decode(param1) as int;
      local2.salvoSize = this.codec_salvoSize.decode(param1) as int;
      local2.shellRadius = this.codec_shellRadius.decode(param1) as Number;
      local2.shotRange = this.codec_shotRange.decode(param1) as Number;
      local2.timeBetweenShotsOfSalvo = this.codec_timeBetweenShotsOfSalvo.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RocketLauncherCC = RocketLauncherCC(param2);
      this.codec_angularVelocity.encode(param1,local3.angularVelocity);
      this.codec_boostPhaseDuration.encode(param1,local3.boostPhaseDuration);
      this.codec_maxSpeed.encode(param1,local3.maxSpeed);
      this.codec_minSpeed.encode(param1,local3.minSpeed);
      this.codec_salvoAimingGracePeriod.encode(param1,local3.salvoAimingGracePeriod);
      this.codec_salvoAimingTime.encode(param1,local3.salvoAimingTime);
      this.codec_salvoReloadTime.encode(param1,local3.salvoReloadTime);
      this.codec_salvoSize.encode(param1,local3.salvoSize);
      this.codec_shellRadius.encode(param1,local3.shellRadius);
      this.codec_shotRange.encode(param1,local3.shotRange);
      this.codec_timeBetweenShotsOfSalvo.encode(param1,local3.timeBetweenShotsOfSalvo);
    }
  }
}
