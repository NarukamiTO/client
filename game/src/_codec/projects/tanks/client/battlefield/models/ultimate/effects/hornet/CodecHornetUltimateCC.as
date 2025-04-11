package _codec.projects.tanks.client.battlefield.models.ultimate.effects.hornet {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.HornetUltimateCC;

  public class CodecHornetUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_effectEnabled:ICodec;
    private var codec_effectStartSound:ICodec;
    private var codec_ring:ICodec;
    private var codec_sonarSound:ICodec;

    public function CodecHornetUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_effectEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_effectStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ring = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_sonarSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HornetUltimateCC = new HornetUltimateCC();
      local2.effectEnabled = this.codec_effectEnabled.decode(param1) as Boolean;
      local2.effectStartSound = this.codec_effectStartSound.decode(param1) as SoundResource;
      local2.ring = this.codec_ring.decode(param1) as TextureResource;
      local2.sonarSound = this.codec_sonarSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HornetUltimateCC = HornetUltimateCC(param2);
      this.codec_effectEnabled.encode(param1,local3.effectEnabled);
      this.codec_effectStartSound.encode(param1,local3.effectStartSound);
      this.codec_ring.encode(param1,local3.ring);
      this.codec_sonarSound.encode(param1,local3.sonarSound);
    }
  }
}
