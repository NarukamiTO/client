package _codec.projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.HunterUltimateCC;

  public class CodecHunterUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargingTimeMillis:ICodec;
    private var codec_effectStartSound:ICodec;
    private var codec_energy:ICodec;
    private var codec_failSound:ICodec;
    private var codec_hitSound:ICodec;
    private var codec_lightning:ICodec;
    private var codec_originPointZOffset:ICodec;
    private var codec_preparing:ICodec;

    public function CodecHunterUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargingTimeMillis = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_effectStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_energy = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_failSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_hitSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightning = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_originPointZOffset = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_preparing = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HunterUltimateCC = new HunterUltimateCC();
      local2.chargingTimeMillis = this.codec_chargingTimeMillis.decode(param1) as int;
      local2.effectStartSound = this.codec_effectStartSound.decode(param1) as SoundResource;
      local2.energy = this.codec_energy.decode(param1) as TextureResource;
      local2.failSound = this.codec_failSound.decode(param1) as SoundResource;
      local2.hitSound = this.codec_hitSound.decode(param1) as SoundResource;
      local2.lightning = this.codec_lightning.decode(param1) as TextureResource;
      local2.originPointZOffset = this.codec_originPointZOffset.decode(param1) as Number;
      local2.preparing = this.codec_preparing.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HunterUltimateCC = HunterUltimateCC(param2);
      this.codec_chargingTimeMillis.encode(param1,local3.chargingTimeMillis);
      this.codec_effectStartSound.encode(param1,local3.effectStartSound);
      this.codec_energy.encode(param1,local3.energy);
      this.codec_failSound.encode(param1,local3.failSound);
      this.codec_hitSound.encode(param1,local3.hitSound);
      this.codec_lightning.encode(param1,local3.lightning);
      this.codec_originPointZOffset.encode(param1,local3.originPointZOffset);
      this.codec_preparing.encode(param1,local3.preparing);
    }
  }
}
