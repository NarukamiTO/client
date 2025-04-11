package _codec.projects.tanks.client.battlefield.models.bonus.bonus.common {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.common.BonusCommonCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecBonusCommonCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_boxResource:ICodec;
    private var codec_cordResource:ICodec;
    private var codec_parachuteInnerResource:ICodec;
    private var codec_parachuteResource:ICodec;
    private var codec_pickupSoundResource:ICodec;

    public function CodecBonusCommonCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_boxResource = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_cordResource = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_parachuteInnerResource = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_parachuteResource = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_pickupSoundResource = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusCommonCC = new BonusCommonCC();
      local2.boxResource = this.codec_boxResource.decode(param1) as Tanks3DSResource;
      local2.cordResource = this.codec_cordResource.decode(param1) as TextureResource;
      local2.parachuteInnerResource = this.codec_parachuteInnerResource.decode(param1) as Tanks3DSResource;
      local2.parachuteResource = this.codec_parachuteResource.decode(param1) as Tanks3DSResource;
      local2.pickupSoundResource = this.codec_pickupSoundResource.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusCommonCC = BonusCommonCC(param2);
      this.codec_boxResource.encode(param1,local3.boxResource);
      this.codec_cordResource.encode(param1,local3.cordResource);
      this.codec_parachuteInnerResource.encode(param1,local3.parachuteInnerResource);
      this.codec_parachuteResource.encode(param1,local3.parachuteResource);
      this.codec_pickupSoundResource.encode(param1,local3.pickupSoundResource);
    }
  }
}
