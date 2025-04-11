package _codec.projects.tanks.client.battlefield.models.ultimate.effects.mammoth {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.MammothUltimateCC;

  public class CodecMammothUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_active:ICodec;
    private var codec_effectLoopSound:ICodec;
    private var codec_effectRadius:ICodec;
    private var codec_effectSparks1Sound:ICodec;
    private var codec_effectSparks2Sound:ICodec;
    private var codec_effectSparks3Sound:ICodec;
    private var codec_effectSparks4Sound:ICodec;
    private var codec_effectStartSound:ICodec;
    private var codec_effectStopSound:ICodec;
    private var codec_heart:ICodec;
    private var codec_shine:ICodec;
    private var codec_sparkles:ICodec;

    public function CodecMammothUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_active = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_effectLoopSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_effectSparks1Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectSparks2Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectSparks3Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectSparks4Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_effectStopSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_heart = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_shine = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_sparkles = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MammothUltimateCC = new MammothUltimateCC();
      local2.active = this.codec_active.decode(param1) as Boolean;
      local2.effectLoopSound = this.codec_effectLoopSound.decode(param1) as SoundResource;
      local2.effectRadius = this.codec_effectRadius.decode(param1) as Number;
      local2.effectSparks1Sound = this.codec_effectSparks1Sound.decode(param1) as SoundResource;
      local2.effectSparks2Sound = this.codec_effectSparks2Sound.decode(param1) as SoundResource;
      local2.effectSparks3Sound = this.codec_effectSparks3Sound.decode(param1) as SoundResource;
      local2.effectSparks4Sound = this.codec_effectSparks4Sound.decode(param1) as SoundResource;
      local2.effectStartSound = this.codec_effectStartSound.decode(param1) as SoundResource;
      local2.effectStopSound = this.codec_effectStopSound.decode(param1) as SoundResource;
      local2.heart = this.codec_heart.decode(param1) as TextureResource;
      local2.shine = this.codec_shine.decode(param1) as TextureResource;
      local2.sparkles = this.codec_sparkles.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MammothUltimateCC = MammothUltimateCC(param2);
      this.codec_active.encode(param1,local3.active);
      this.codec_effectLoopSound.encode(param1,local3.effectLoopSound);
      this.codec_effectRadius.encode(param1,local3.effectRadius);
      this.codec_effectSparks1Sound.encode(param1,local3.effectSparks1Sound);
      this.codec_effectSparks2Sound.encode(param1,local3.effectSparks2Sound);
      this.codec_effectSparks3Sound.encode(param1,local3.effectSparks3Sound);
      this.codec_effectSparks4Sound.encode(param1,local3.effectSparks4Sound);
      this.codec_effectStartSound.encode(param1,local3.effectStartSound);
      this.codec_effectStopSound.encode(param1,local3.effectStopSound);
      this.codec_heart.encode(param1,local3.heart);
      this.codec_shine.encode(param1,local3.shine);
      this.codec_sparkles.encode(param1,local3.sparkles);
    }
  }
}
