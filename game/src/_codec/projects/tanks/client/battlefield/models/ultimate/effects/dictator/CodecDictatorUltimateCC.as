package _codec.projects.tanks.client.battlefield.models.ultimate.effects.dictator {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.dictator.DictatorUltimateCC;

  public class CodecDictatorUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_activationSound:ICodec;
    private var codec_beam:ICodec;
    private var codec_beamScale:ICodec;
    private var codec_secondaryBeamScale:ICodec;
    private var codec_star:ICodec;
    private var codec_wave:ICodec;
    private var codec_waveSize:ICodec;

    public function CodecDictatorUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_activationSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_beam = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_beamScale = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_secondaryBeamScale = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_star = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_wave = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_waveSize = param1.getCodec(new TypeCodecInfo(Number,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DictatorUltimateCC = new DictatorUltimateCC();
      local2.activationSound = this.codec_activationSound.decode(param1) as SoundResource;
      local2.beam = this.codec_beam.decode(param1) as TextureResource;
      local2.beamScale = this.codec_beamScale.decode(param1) as Number;
      local2.secondaryBeamScale = this.codec_secondaryBeamScale.decode(param1) as Number;
      local2.star = this.codec_star.decode(param1) as TextureResource;
      local2.wave = this.codec_wave.decode(param1) as TextureResource;
      local2.waveSize = this.codec_waveSize.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DictatorUltimateCC = DictatorUltimateCC(param2);
      this.codec_activationSound.encode(param1,local3.activationSound);
      this.codec_beam.encode(param1,local3.beam);
      this.codec_beamScale.encode(param1,local3.beamScale);
      this.codec_secondaryBeamScale.encode(param1,local3.secondaryBeamScale);
      this.codec_star.encode(param1,local3.star);
      this.codec_wave.encode(param1,local3.wave);
      this.codec_waveSize.encode(param1,local3.waveSize);
    }
  }
}
