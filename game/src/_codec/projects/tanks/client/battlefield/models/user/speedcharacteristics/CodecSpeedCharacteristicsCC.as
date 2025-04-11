package _codec.projects.tanks.client.battlefield.models.user.speedcharacteristics {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsCC;

  public class CodecSpeedCharacteristicsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_baseAcceleration:ICodec;
    private var codec_baseSpeed:ICodec;
    private var codec_baseTurnSpeed:ICodec;
    private var codec_baseTurretRotationSpeed:ICodec;
    private var codec_currentAcceleration:ICodec;
    private var codec_currentSpeed:ICodec;
    private var codec_currentTurnSpeed:ICodec;
    private var codec_currentTurretRotationSpeed:ICodec;
    private var codec_reverseAcceleration:ICodec;
    private var codec_reverseTurnAcceleration:ICodec;
    private var codec_sideAcceleration:ICodec;
    private var codec_turnAcceleration:ICodec;
    private var codec_turnStabilizationAcceleration:ICodec;

    public function CodecSpeedCharacteristicsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_baseAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_baseSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_baseTurnSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_baseTurretRotationSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_currentAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_currentSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_currentTurnSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_currentTurretRotationSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_reverseAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_reverseTurnAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_sideAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_turnAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_turnStabilizationAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SpeedCharacteristicsCC = new SpeedCharacteristicsCC();
      local2.baseAcceleration = this.codec_baseAcceleration.decode(param1) as Number;
      local2.baseSpeed = this.codec_baseSpeed.decode(param1) as Number;
      local2.baseTurnSpeed = this.codec_baseTurnSpeed.decode(param1) as Number;
      local2.baseTurretRotationSpeed = this.codec_baseTurretRotationSpeed.decode(param1) as Number;
      local2.currentAcceleration = this.codec_currentAcceleration.decode(param1) as Number;
      local2.currentSpeed = this.codec_currentSpeed.decode(param1) as Number;
      local2.currentTurnSpeed = this.codec_currentTurnSpeed.decode(param1) as Number;
      local2.currentTurretRotationSpeed = this.codec_currentTurretRotationSpeed.decode(param1) as Number;
      local2.reverseAcceleration = this.codec_reverseAcceleration.decode(param1) as Number;
      local2.reverseTurnAcceleration = this.codec_reverseTurnAcceleration.decode(param1) as Number;
      local2.sideAcceleration = this.codec_sideAcceleration.decode(param1) as Number;
      local2.turnAcceleration = this.codec_turnAcceleration.decode(param1) as Number;
      local2.turnStabilizationAcceleration = this.codec_turnStabilizationAcceleration.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SpeedCharacteristicsCC = SpeedCharacteristicsCC(param2);
      this.codec_baseAcceleration.encode(param1,local3.baseAcceleration);
      this.codec_baseSpeed.encode(param1,local3.baseSpeed);
      this.codec_baseTurnSpeed.encode(param1,local3.baseTurnSpeed);
      this.codec_baseTurretRotationSpeed.encode(param1,local3.baseTurretRotationSpeed);
      this.codec_currentAcceleration.encode(param1,local3.currentAcceleration);
      this.codec_currentSpeed.encode(param1,local3.currentSpeed);
      this.codec_currentTurnSpeed.encode(param1,local3.currentTurnSpeed);
      this.codec_currentTurretRotationSpeed.encode(param1,local3.currentTurretRotationSpeed);
      this.codec_reverseAcceleration.encode(param1,local3.reverseAcceleration);
      this.codec_reverseTurnAcceleration.encode(param1,local3.reverseTurnAcceleration);
      this.codec_sideAcceleration.encode(param1,local3.sideAcceleration);
      this.codec_turnAcceleration.encode(param1,local3.turnAcceleration);
      this.codec_turnStabilizationAcceleration.encode(param1,local3.turnStabilizationAcceleration);
    }
  }
}
