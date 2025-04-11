package _codec.projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb.WaspUltimateBombCC;

  public class CodecWaspUltimateBombCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bombBeepSound:ICodec;
    private var codec_bombPlacedSound:ICodec;
    private var codec_countdown:ICodec;
    private var codec_craterDecal:ICodec;
    private var codec_farCountdown:ICodec;
    private var codec_nuclearBangFlame:ICodec;
    private var codec_nuclearBangLight:ICodec;
    private var codec_nuclearBangSmoke:ICodec;
    private var codec_nuclearBangSound:ICodec;
    private var codec_nuclearBangWave:ICodec;
    private var codec_timeLeft:ICodec;

    public function CodecWaspUltimateBombCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bombBeepSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_bombPlacedSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_countdown = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_craterDecal = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_farCountdown = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_nuclearBangFlame = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_nuclearBangLight = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_nuclearBangSmoke = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_nuclearBangSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_nuclearBangWave = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_timeLeft = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:WaspUltimateBombCC = new WaspUltimateBombCC();
      local2.bombBeepSound = this.codec_bombBeepSound.decode(param1) as SoundResource;
      local2.bombPlacedSound = this.codec_bombPlacedSound.decode(param1) as SoundResource;
      local2.countdown = this.codec_countdown.decode(param1) as MultiframeTextureResource;
      local2.craterDecal = this.codec_craterDecal.decode(param1) as TextureResource;
      local2.farCountdown = this.codec_farCountdown.decode(param1) as MultiframeTextureResource;
      local2.nuclearBangFlame = this.codec_nuclearBangFlame.decode(param1) as TextureResource;
      local2.nuclearBangLight = this.codec_nuclearBangLight.decode(param1) as TextureResource;
      local2.nuclearBangSmoke = this.codec_nuclearBangSmoke.decode(param1) as TextureResource;
      local2.nuclearBangSound = this.codec_nuclearBangSound.decode(param1) as SoundResource;
      local2.nuclearBangWave = this.codec_nuclearBangWave.decode(param1) as TextureResource;
      local2.timeLeft = this.codec_timeLeft.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:WaspUltimateBombCC = WaspUltimateBombCC(param2);
      this.codec_bombBeepSound.encode(param1,local3.bombBeepSound);
      this.codec_bombPlacedSound.encode(param1,local3.bombPlacedSound);
      this.codec_countdown.encode(param1,local3.countdown);
      this.codec_craterDecal.encode(param1,local3.craterDecal);
      this.codec_farCountdown.encode(param1,local3.farCountdown);
      this.codec_nuclearBangFlame.encode(param1,local3.nuclearBangFlame);
      this.codec_nuclearBangLight.encode(param1,local3.nuclearBangLight);
      this.codec_nuclearBangSmoke.encode(param1,local3.nuclearBangSmoke);
      this.codec_nuclearBangSound.encode(param1,local3.nuclearBangSound);
      this.codec_nuclearBangWave.encode(param1,local3.nuclearBangWave);
      this.codec_timeLeft.encode(param1,local3.timeLeft);
    }
  }
}
