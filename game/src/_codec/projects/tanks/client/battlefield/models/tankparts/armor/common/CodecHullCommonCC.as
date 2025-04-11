package _codec.projects.tanks.client.battlefield.models.tankparts.armor.common {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecHullCommonCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_deadColoring:ICodec;
    private var codec_deathSound:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_mass:ICodec;
    private var codec_stunEffectTexture:ICodec;
    private var codec_stunSound:ICodec;
    private var codec_ultimateHudIndicator:ICodec;
    private var codec_ultimateIconIndex:ICodec;

    public function CodecHullCommonCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_deadColoring = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_deathSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_mass = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_stunEffectTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_stunSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ultimateHudIndicator = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_ultimateIconIndex = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HullCommonCC = new HullCommonCC();
      local2.deadColoring = this.codec_deadColoring.decode(param1) as TextureResource;
      local2.deathSound = this.codec_deathSound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.mass = this.codec_mass.decode(param1) as Number;
      local2.stunEffectTexture = this.codec_stunEffectTexture.decode(param1) as TextureResource;
      local2.stunSound = this.codec_stunSound.decode(param1) as SoundResource;
      local2.ultimateHudIndicator = this.codec_ultimateHudIndicator.decode(param1) as TextureResource;
      local2.ultimateIconIndex = this.codec_ultimateIconIndex.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HullCommonCC = HullCommonCC(param2);
      this.codec_deadColoring.encode(param1,local3.deadColoring);
      this.codec_deathSound.encode(param1,local3.deathSound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_mass.encode(param1,local3.mass);
      this.codec_stunEffectTexture.encode(param1,local3.stunEffectTexture);
      this.codec_stunSound.encode(param1,local3.stunSound);
      this.codec_ultimateHudIndicator.encode(param1,local3.ultimateHudIndicator);
      this.codec_ultimateIconIndex.encode(param1,local3.ultimateIconIndex);
    }
  }
}
