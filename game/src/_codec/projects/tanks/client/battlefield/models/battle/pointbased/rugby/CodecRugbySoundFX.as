package _codec.projects.tanks.client.battlefield.models.battle.pointbased.rugby {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbySoundFX;

  public class CodecRugbySoundFX implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_ballDropNegativeSound:ICodec;
    private var codec_ballDropPositiveSound:ICodec;
    private var codec_ballFaceOffSound:ICodec;
    private var codec_ballTakeNegativeSound:ICodec;
    private var codec_ballTakePositiveSound:ICodec;
    private var codec_goalNegativeSound:ICodec;
    private var codec_goalPositiveSound:ICodec;

    public function CodecRugbySoundFX() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_ballDropNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ballDropPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ballFaceOffSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ballTakeNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ballTakePositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_goalNegativeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_goalPositiveSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RugbySoundFX = new RugbySoundFX();
      local2.ballDropNegativeSound = this.codec_ballDropNegativeSound.decode(param1) as SoundResource;
      local2.ballDropPositiveSound = this.codec_ballDropPositiveSound.decode(param1) as SoundResource;
      local2.ballFaceOffSound = this.codec_ballFaceOffSound.decode(param1) as SoundResource;
      local2.ballTakeNegativeSound = this.codec_ballTakeNegativeSound.decode(param1) as SoundResource;
      local2.ballTakePositiveSound = this.codec_ballTakePositiveSound.decode(param1) as SoundResource;
      local2.goalNegativeSound = this.codec_goalNegativeSound.decode(param1) as SoundResource;
      local2.goalPositiveSound = this.codec_goalPositiveSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RugbySoundFX = RugbySoundFX(param2);
      this.codec_ballDropNegativeSound.encode(param1,local3.ballDropNegativeSound);
      this.codec_ballDropPositiveSound.encode(param1,local3.ballDropPositiveSound);
      this.codec_ballFaceOffSound.encode(param1,local3.ballFaceOffSound);
      this.codec_ballTakeNegativeSound.encode(param1,local3.ballTakeNegativeSound);
      this.codec_ballTakePositiveSound.encode(param1,local3.ballTakePositiveSound);
      this.codec_goalNegativeSound.encode(param1,local3.goalNegativeSound);
      this.codec_goalPositiveSound.encode(param1,local3.goalPositiveSound);
    }
  }
}
