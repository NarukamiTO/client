package _codec.projects.tanks.client.battlefield.models.battle.pointbased.assault {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultSoundFX;

  public class CodecAssaultSoundFX implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flagDropSound:ICodec;
    private var codec_flagReturnSound:ICodec;
    private var codec_flagTakeSound:ICodec;
    private var codec_winSound:ICodec;

    public function CodecAssaultSoundFX() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flagDropSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_flagReturnSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_flagTakeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_winSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AssaultSoundFX = new AssaultSoundFX();
      local2.flagDropSound = this.codec_flagDropSound.decode(param1) as SoundResource;
      local2.flagReturnSound = this.codec_flagReturnSound.decode(param1) as SoundResource;
      local2.flagTakeSound = this.codec_flagTakeSound.decode(param1) as SoundResource;
      local2.winSound = this.codec_winSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AssaultSoundFX = AssaultSoundFX(param2);
      this.codec_flagDropSound.encode(param1,local3.flagDropSound);
      this.codec_flagReturnSound.encode(param1,local3.flagReturnSound);
      this.codec_flagTakeSound.encode(param1,local3.flagTakeSound);
      this.codec_winSound.encode(param1,local3.winSound);
    }
  }
}
