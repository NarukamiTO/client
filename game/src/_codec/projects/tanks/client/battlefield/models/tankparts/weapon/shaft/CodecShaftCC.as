package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.shaft {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;

  public class CodecShaftCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_afterShotPause:ICodec;
    private var codec_aimingImpact:ICodec;
    private var codec_chargeRate:ICodec;
    private var codec_dischargeRate:ICodec;
    private var codec_fastShotEnergy:ICodec;
    private var codec_horizontalTargetingSpeed:ICodec;
    private var codec_initialFOV:ICodec;
    private var codec_maxEnergy:ICodec;
    private var codec_minAimedShotEnergy:ICodec;
    private var codec_minimumFOV:ICodec;
    private var codec_reticleImage:ICodec;
    private var codec_rotationCoeffKmin:ICodec;
    private var codec_rotationCoeffT1:ICodec;
    private var codec_rotationCoeffT2:ICodec;
    private var codec_shrubsHidingRadiusMax:ICodec;
    private var codec_shrubsHidingRadiusMin:ICodec;
    private var codec_targetingAcceleration:ICodec;
    private var codec_targetingTransitionTime:ICodec;
    private var codec_verticalTargetingSpeed:ICodec;

    public function CodecShaftCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_afterShotPause = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_aimingImpact = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_chargeRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dischargeRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_fastShotEnergy = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_horizontalTargetingSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_initialFOV = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_maxEnergy = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minAimedShotEnergy = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minimumFOV = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_reticleImage = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_rotationCoeffKmin = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_rotationCoeffT1 = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_rotationCoeffT2 = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shrubsHidingRadiusMax = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shrubsHidingRadiusMin = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_targetingAcceleration = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_targetingTransitionTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_verticalTargetingSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShaftCC = new ShaftCC();
      local2.afterShotPause = this.codec_afterShotPause.decode(param1) as int;
      local2.aimingImpact = this.codec_aimingImpact.decode(param1) as Number;
      local2.chargeRate = this.codec_chargeRate.decode(param1) as Number;
      local2.dischargeRate = this.codec_dischargeRate.decode(param1) as Number;
      local2.fastShotEnergy = this.codec_fastShotEnergy.decode(param1) as Number;
      local2.horizontalTargetingSpeed = this.codec_horizontalTargetingSpeed.decode(param1) as Number;
      local2.initialFOV = this.codec_initialFOV.decode(param1) as Number;
      local2.maxEnergy = this.codec_maxEnergy.decode(param1) as Number;
      local2.minAimedShotEnergy = this.codec_minAimedShotEnergy.decode(param1) as Number;
      local2.minimumFOV = this.codec_minimumFOV.decode(param1) as Number;
      local2.reticleImage = this.codec_reticleImage.decode(param1) as TextureResource;
      local2.rotationCoeffKmin = this.codec_rotationCoeffKmin.decode(param1) as Number;
      local2.rotationCoeffT1 = this.codec_rotationCoeffT1.decode(param1) as Number;
      local2.rotationCoeffT2 = this.codec_rotationCoeffT2.decode(param1) as Number;
      local2.shrubsHidingRadiusMax = this.codec_shrubsHidingRadiusMax.decode(param1) as Number;
      local2.shrubsHidingRadiusMin = this.codec_shrubsHidingRadiusMin.decode(param1) as Number;
      local2.targetingAcceleration = this.codec_targetingAcceleration.decode(param1) as Number;
      local2.targetingTransitionTime = this.codec_targetingTransitionTime.decode(param1) as int;
      local2.verticalTargetingSpeed = this.codec_verticalTargetingSpeed.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShaftCC = ShaftCC(param2);
      this.codec_afterShotPause.encode(param1,local3.afterShotPause);
      this.codec_aimingImpact.encode(param1,local3.aimingImpact);
      this.codec_chargeRate.encode(param1,local3.chargeRate);
      this.codec_dischargeRate.encode(param1,local3.dischargeRate);
      this.codec_fastShotEnergy.encode(param1,local3.fastShotEnergy);
      this.codec_horizontalTargetingSpeed.encode(param1,local3.horizontalTargetingSpeed);
      this.codec_initialFOV.encode(param1,local3.initialFOV);
      this.codec_maxEnergy.encode(param1,local3.maxEnergy);
      this.codec_minAimedShotEnergy.encode(param1,local3.minAimedShotEnergy);
      this.codec_minimumFOV.encode(param1,local3.minimumFOV);
      this.codec_reticleImage.encode(param1,local3.reticleImage);
      this.codec_rotationCoeffKmin.encode(param1,local3.rotationCoeffKmin);
      this.codec_rotationCoeffT1.encode(param1,local3.rotationCoeffT1);
      this.codec_rotationCoeffT2.encode(param1,local3.rotationCoeffT2);
      this.codec_shrubsHidingRadiusMax.encode(param1,local3.shrubsHidingRadiusMax);
      this.codec_shrubsHidingRadiusMin.encode(param1,local3.shrubsHidingRadiusMin);
      this.codec_targetingAcceleration.encode(param1,local3.targetingAcceleration);
      this.codec_targetingTransitionTime.encode(param1,local3.targetingTransitionTime);
      this.codec_verticalTargetingSpeed.encode(param1,local3.verticalTargetingSpeed);
    }
  }
}
