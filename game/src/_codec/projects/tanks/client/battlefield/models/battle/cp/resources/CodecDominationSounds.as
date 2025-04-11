package _codec.projects.tanks.client.battlefield.models.battle.cp.resources {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;

  public class CodecDominationSounds implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_pointCaptureStartNegativeSound:ICodec;
    private var codec_pointCaptureStartPositiveSound:ICodec;
    private var codec_pointCaptureStopNegativeSound:ICodec;
    private var codec_pointCaptureStopPositiveSound:ICodec;
    private var codec_pointCapturedNegativeSound:ICodec;
    private var codec_pointCapturedPositiveSound:ICodec;
    private var codec_pointNeutralizedNegativeSound:ICodec;
    private var codec_pointNeutralizedPositiveSound:ICodec;
    private var codec_pointScoreDecreasingSound:ICodec;
    private var codec_pointScoreIncreasingSound:ICodec;

    public function CodecDominationSounds() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_pointCaptureStartNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointCaptureStartPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointCaptureStopNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointCaptureStopPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointCapturedNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointCapturedPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointNeutralizedNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointNeutralizedPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointScoreDecreasingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pointScoreIncreasingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DominationSounds = new DominationSounds();
      local2.pointCaptureStartNegativeSound = this.codec_pointCaptureStartNegativeSound.decode(param1) as SoundResource;
      local2.pointCaptureStartPositiveSound = this.codec_pointCaptureStartPositiveSound.decode(param1) as SoundResource;
      local2.pointCaptureStopNegativeSound = this.codec_pointCaptureStopNegativeSound.decode(param1) as SoundResource;
      local2.pointCaptureStopPositiveSound = this.codec_pointCaptureStopPositiveSound.decode(param1) as SoundResource;
      local2.pointCapturedNegativeSound = this.codec_pointCapturedNegativeSound.decode(param1) as SoundResource;
      local2.pointCapturedPositiveSound = this.codec_pointCapturedPositiveSound.decode(param1) as SoundResource;
      local2.pointNeutralizedNegativeSound = this.codec_pointNeutralizedNegativeSound.decode(param1) as SoundResource;
      local2.pointNeutralizedPositiveSound = this.codec_pointNeutralizedPositiveSound.decode(param1) as SoundResource;
      local2.pointScoreDecreasingSound = this.codec_pointScoreDecreasingSound.decode(param1) as SoundResource;
      local2.pointScoreIncreasingSound = this.codec_pointScoreIncreasingSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DominationSounds = DominationSounds(param2);
      this.codec_pointCaptureStartNegativeSound.encode(param1,local3.pointCaptureStartNegativeSound);
      this.codec_pointCaptureStartPositiveSound.encode(param1,local3.pointCaptureStartPositiveSound);
      this.codec_pointCaptureStopNegativeSound.encode(param1,local3.pointCaptureStopNegativeSound);
      this.codec_pointCaptureStopPositiveSound.encode(param1,local3.pointCaptureStopPositiveSound);
      this.codec_pointCapturedNegativeSound.encode(param1,local3.pointCapturedNegativeSound);
      this.codec_pointCapturedPositiveSound.encode(param1,local3.pointCapturedPositiveSound);
      this.codec_pointNeutralizedNegativeSound.encode(param1,local3.pointNeutralizedNegativeSound);
      this.codec_pointNeutralizedPositiveSound.encode(param1,local3.pointNeutralizedPositiveSound);
      this.codec_pointScoreDecreasingSound.encode(param1,local3.pointScoreDecreasingSound);
      this.codec_pointScoreIncreasingSound.encode(param1,local3.pointScoreIncreasingSound);
    }
  }
}
