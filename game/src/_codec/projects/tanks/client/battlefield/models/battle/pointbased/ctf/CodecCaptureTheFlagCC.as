package _codec.projects.tanks.client.battlefield.models.battle.pointbased.ctf {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagSoundFX;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecCaptureTheFlagCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_blueFlagSprite:ICodec;
    private var codec_bluePedestalModel:ICodec;
    private var codec_redFlagSprite:ICodec;
    private var codec_redPedestalModel:ICodec;
    private var codec_sounds:ICodec;

    public function CodecCaptureTheFlagCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_blueFlagSprite = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bluePedestalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_redFlagSprite = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redPedestalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_sounds = param1.getCodec(new TypeCodecInfo(CaptureTheFlagSoundFX,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CaptureTheFlagCC = new CaptureTheFlagCC();
      local2.blueFlagSprite = this.codec_blueFlagSprite.decode(param1) as TextureResource;
      local2.bluePedestalModel = this.codec_bluePedestalModel.decode(param1) as Tanks3DSResource;
      local2.redFlagSprite = this.codec_redFlagSprite.decode(param1) as TextureResource;
      local2.redPedestalModel = this.codec_redPedestalModel.decode(param1) as Tanks3DSResource;
      local2.sounds = this.codec_sounds.decode(param1) as CaptureTheFlagSoundFX;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CaptureTheFlagCC = CaptureTheFlagCC(param2);
      this.codec_blueFlagSprite.encode(param1,local3.blueFlagSprite);
      this.codec_bluePedestalModel.encode(param1,local3.bluePedestalModel);
      this.codec_redFlagSprite.encode(param1,local3.redFlagSprite);
      this.codec_redPedestalModel.encode(param1,local3.redPedestalModel);
      this.codec_sounds.encode(param1,local3.sounds);
    }
  }
}
