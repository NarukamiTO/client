package _codec.projects.tanks.client.battlefield.models.battle.pointbased.assault {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultSoundFX;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecAssaultCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flagPedestalModel:ICodec;
    private var codec_flagSprite:ICodec;
    private var codec_pointBigMarker:ICodec;
    private var codec_pointPedestalModel:ICodec;
    private var codec_pointSmallMarker:ICodec;
    private var codec_sounds:ICodec;

    public function CodecAssaultCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flagPedestalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_flagSprite = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_pointBigMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_pointPedestalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_pointSmallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_sounds = param1.getCodec(new TypeCodecInfo(AssaultSoundFX,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AssaultCC = new AssaultCC();
      local2.flagPedestalModel = this.codec_flagPedestalModel.decode(param1) as Tanks3DSResource;
      local2.flagSprite = this.codec_flagSprite.decode(param1) as TextureResource;
      local2.pointBigMarker = this.codec_pointBigMarker.decode(param1) as TextureResource;
      local2.pointPedestalModel = this.codec_pointPedestalModel.decode(param1) as Tanks3DSResource;
      local2.pointSmallMarker = this.codec_pointSmallMarker.decode(param1) as TextureResource;
      local2.sounds = this.codec_sounds.decode(param1) as AssaultSoundFX;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AssaultCC = AssaultCC(param2);
      this.codec_flagPedestalModel.encode(param1,local3.flagPedestalModel);
      this.codec_flagSprite.encode(param1,local3.flagSprite);
      this.codec_pointBigMarker.encode(param1,local3.pointBigMarker);
      this.codec_pointPedestalModel.encode(param1,local3.pointPedestalModel);
      this.codec_pointSmallMarker.encode(param1,local3.pointSmallMarker);
      this.codec_sounds.encode(param1,local3.sounds);
    }
  }
}
