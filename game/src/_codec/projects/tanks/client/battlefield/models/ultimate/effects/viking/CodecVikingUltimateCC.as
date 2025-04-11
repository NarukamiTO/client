package _codec.projects.tanks.client.battlefield.models.ultimate.effects.viking {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.viking.VikingUltimateCC;

  public class CodecVikingUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_effectEnabled:ICodec;
    private var codec_effectEndSound:ICodec;
    private var codec_effectSound:ICodec;
    private var codec_effectStartSound:ICodec;
    private var codec_flame:ICodec;
    private var codec_smoke:ICodec;

    public function CodecVikingUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_effectEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_effectEndSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_flame = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_smoke = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:VikingUltimateCC = new VikingUltimateCC();
      local2.effectEnabled = this.codec_effectEnabled.decode(param1) as Boolean;
      local2.effectEndSound = this.codec_effectEndSound.decode(param1) as SoundResource;
      local2.effectSound = this.codec_effectSound.decode(param1) as SoundResource;
      local2.effectStartSound = this.codec_effectStartSound.decode(param1) as SoundResource;
      local2.flame = this.codec_flame.decode(param1) as TextureResource;
      local2.smoke = this.codec_smoke.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:VikingUltimateCC = VikingUltimateCC(param2);
      this.codec_effectEnabled.encode(param1,local3.effectEnabled);
      this.codec_effectEndSound.encode(param1,local3.effectEndSound);
      this.codec_effectSound.encode(param1,local3.effectSound);
      this.codec_effectStartSound.encode(param1,local3.effectStartSound);
      this.codec_flame.encode(param1,local3.flame);
      this.codec_smoke.encode(param1,local3.smoke);
    }
  }
}
