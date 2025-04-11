package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.artillery {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;

  public class CodecArtilleryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargingTime:ICodec;
    private var codec_initialTurretAngle:ICodec;
    private var codec_maxShellSpeed:ICodec;
    private var codec_minShellSpeed:ICodec;
    private var codec_shellGravityCoef:ICodec;
    private var codec_shellRadius:ICodec;
    private var codec_speedsCount:ICodec;

    public function CodecArtilleryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargingTime = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_initialTurretAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_maxShellSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minShellSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shellGravityCoef = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shellRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_speedsCount = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ArtilleryCC = new ArtilleryCC();
      local2.chargingTime = this.codec_chargingTime.decode(param1) as Number;
      local2.initialTurretAngle = this.codec_initialTurretAngle.decode(param1) as Number;
      local2.maxShellSpeed = this.codec_maxShellSpeed.decode(param1) as Number;
      local2.minShellSpeed = this.codec_minShellSpeed.decode(param1) as Number;
      local2.shellGravityCoef = this.codec_shellGravityCoef.decode(param1) as Number;
      local2.shellRadius = this.codec_shellRadius.decode(param1) as Number;
      local2.speedsCount = this.codec_speedsCount.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ArtilleryCC = ArtilleryCC(param2);
      this.codec_chargingTime.encode(param1,local3.chargingTime);
      this.codec_initialTurretAngle.encode(param1,local3.initialTurretAngle);
      this.codec_maxShellSpeed.encode(param1,local3.maxShellSpeed);
      this.codec_minShellSpeed.encode(param1,local3.minShellSpeed);
      this.codec_shellGravityCoef.encode(param1,local3.shellGravityCoef);
      this.codec_shellRadius.encode(param1,local3.shellRadius);
      this.codec_speedsCount.encode(param1,local3.speedsCount);
    }
  }
}
