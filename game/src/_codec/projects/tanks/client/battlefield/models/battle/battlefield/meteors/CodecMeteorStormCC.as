package _codec.projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorDescriptor;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorStormCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecMeteorStormCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bigSplashRadius:ICodec;
    private var codec_craterDecal:ICodec;
    private var codec_currentMeteors:ICodec;
    private var codec_impactSoundTimelabel:ICodec;
    private var codec_meteorArrivingSound:ICodec;
    private var codec_meteorDistantSound:ICodec;
    private var codec_meteorFlyDistance:ICodec;
    private var codec_meteorModel:ICodec;
    private var codec_meteorSpeed:ICodec;
    private var codec_nuclearBangFlame:ICodec;
    private var codec_nuclearBangLight:ICodec;
    private var codec_nuclearBangSmoke:ICodec;
    private var codec_nuclearBangSound:ICodec;
    private var codec_nuclearBangWave:ICodec;
    private var codec_preferredFallAngle:ICodec;
    private var codec_smallSplashRadius:ICodec;
    private var codec_splashDamageImpact:ICodec;
    private var codec_splashDamageMinPercent:ICodec;
    private var codec_tailFlame:ICodec;
    private var codec_tailLight:ICodec;
    private var codec_tailSmoke:ICodec;

    public function CodecMeteorStormCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bigSplashRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_craterDecal = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_currentMeteors = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(MeteorDescriptor,false),false,1));
      this.codec_impactSoundTimelabel = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_meteorArrivingSound = param1.getCodec(new TypeCodecInfo(SoundResource,true));
      this.codec_meteorDistantSound = param1.getCodec(new TypeCodecInfo(SoundResource,true));
      this.codec_meteorFlyDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_meteorModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,true));
      this.codec_meteorSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_nuclearBangFlame = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_nuclearBangLight = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_nuclearBangSmoke = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_nuclearBangSound = param1.getCodec(new TypeCodecInfo(SoundResource,true));
      this.codec_nuclearBangWave = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_preferredFallAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_smallSplashRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_splashDamageImpact = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_splashDamageMinPercent = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_tailFlame = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_tailLight = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(LightEffectItem,false),false,1));
      this.codec_tailSmoke = param1.getCodec(new TypeCodecInfo(TextureResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MeteorStormCC = new MeteorStormCC();
      local2.bigSplashRadius = this.codec_bigSplashRadius.decode(param1) as Number;
      local2.craterDecal = this.codec_craterDecal.decode(param1) as TextureResource;
      local2.currentMeteors = this.codec_currentMeteors.decode(param1) as Vector.<MeteorDescriptor>;
      local2.impactSoundTimelabel = this.codec_impactSoundTimelabel.decode(param1) as int;
      local2.meteorArrivingSound = this.codec_meteorArrivingSound.decode(param1) as SoundResource;
      local2.meteorDistantSound = this.codec_meteorDistantSound.decode(param1) as SoundResource;
      local2.meteorFlyDistance = this.codec_meteorFlyDistance.decode(param1) as Number;
      local2.meteorModel = this.codec_meteorModel.decode(param1) as Tanks3DSResource;
      local2.meteorSpeed = this.codec_meteorSpeed.decode(param1) as Number;
      local2.nuclearBangFlame = this.codec_nuclearBangFlame.decode(param1) as TextureResource;
      local2.nuclearBangLight = this.codec_nuclearBangLight.decode(param1) as TextureResource;
      local2.nuclearBangSmoke = this.codec_nuclearBangSmoke.decode(param1) as TextureResource;
      local2.nuclearBangSound = this.codec_nuclearBangSound.decode(param1) as SoundResource;
      local2.nuclearBangWave = this.codec_nuclearBangWave.decode(param1) as TextureResource;
      local2.preferredFallAngle = this.codec_preferredFallAngle.decode(param1) as Number;
      local2.smallSplashRadius = this.codec_smallSplashRadius.decode(param1) as Number;
      local2.splashDamageImpact = this.codec_splashDamageImpact.decode(param1) as Number;
      local2.splashDamageMinPercent = this.codec_splashDamageMinPercent.decode(param1) as Number;
      local2.tailFlame = this.codec_tailFlame.decode(param1) as TextureResource;
      local2.tailLight = this.codec_tailLight.decode(param1) as Vector.<LightEffectItem>;
      local2.tailSmoke = this.codec_tailSmoke.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MeteorStormCC = MeteorStormCC(param2);
      this.codec_bigSplashRadius.encode(param1,local3.bigSplashRadius);
      this.codec_craterDecal.encode(param1,local3.craterDecal);
      this.codec_currentMeteors.encode(param1,local3.currentMeteors);
      this.codec_impactSoundTimelabel.encode(param1,local3.impactSoundTimelabel);
      this.codec_meteorArrivingSound.encode(param1,local3.meteorArrivingSound);
      this.codec_meteorDistantSound.encode(param1,local3.meteorDistantSound);
      this.codec_meteorFlyDistance.encode(param1,local3.meteorFlyDistance);
      this.codec_meteorModel.encode(param1,local3.meteorModel);
      this.codec_meteorSpeed.encode(param1,local3.meteorSpeed);
      this.codec_nuclearBangFlame.encode(param1,local3.nuclearBangFlame);
      this.codec_nuclearBangLight.encode(param1,local3.nuclearBangLight);
      this.codec_nuclearBangSmoke.encode(param1,local3.nuclearBangSmoke);
      this.codec_nuclearBangSound.encode(param1,local3.nuclearBangSound);
      this.codec_nuclearBangWave.encode(param1,local3.nuclearBangWave);
      this.codec_preferredFallAngle.encode(param1,local3.preferredFallAngle);
      this.codec_smallSplashRadius.encode(param1,local3.smallSplashRadius);
      this.codec_splashDamageImpact.encode(param1,local3.splashDamageImpact);
      this.codec_splashDamageMinPercent.encode(param1,local3.splashDamageMinPercent);
      this.codec_tailFlame.encode(param1,local3.tailFlame);
      this.codec_tailLight.encode(param1,local3.tailLight);
      this.codec_tailSmoke.encode(param1,local3.tailSmoke);
    }
  }
}
