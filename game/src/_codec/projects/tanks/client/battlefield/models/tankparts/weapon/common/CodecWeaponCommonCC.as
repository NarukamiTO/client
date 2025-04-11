package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.common {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonCC;

  public class CodecWeaponCommonCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buffShotCooldownMs:ICodec;
    private var codec_buffed:ICodec;
    private var codec_highlightingDistance:ICodec;
    private var codec_impactForce:ICodec;
    private var codec_kickback:ICodec;
    private var codec_turretRotationAcceleration:ICodec;
    private var codec_turretRotationSound:ICodec;
    private var codec_turretRotationSpeed:ICodec;

    public function CodecWeaponCommonCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buffShotCooldownMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_buffed = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_highlightingDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_impactForce = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_kickback = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_turretRotationAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_turretRotationSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_turretRotationSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:WeaponCommonCC = new WeaponCommonCC();
      local2.buffShotCooldownMs = this.codec_buffShotCooldownMs.decode(param1) as int;
      local2.buffed = this.codec_buffed.decode(param1) as Boolean;
      local2.highlightingDistance = this.codec_highlightingDistance.decode(param1) as Number;
      local2.impactForce = this.codec_impactForce.decode(param1) as Number;
      local2.kickback = this.codec_kickback.decode(param1) as Number;
      local2.turretRotationAcceleration = this.codec_turretRotationAcceleration.decode(param1) as Number;
      local2.turretRotationSound = this.codec_turretRotationSound.decode(param1) as SoundResource;
      local2.turretRotationSpeed = this.codec_turretRotationSpeed.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:WeaponCommonCC = WeaponCommonCC(param2);
      this.codec_buffShotCooldownMs.encode(param1,local3.buffShotCooldownMs);
      this.codec_buffed.encode(param1,local3.buffed);
      this.codec_highlightingDistance.encode(param1,local3.highlightingDistance);
      this.codec_impactForce.encode(param1,local3.impactForce);
      this.codec_kickback.encode(param1,local3.kickback);
      this.codec_turretRotationAcceleration.encode(param1,local3.turretRotationAcceleration);
      this.codec_turretRotationSound.encode(param1,local3.turretRotationSound);
      this.codec_turretRotationSpeed.encode(param1,local3.turretRotationSpeed);
    }
  }
}
