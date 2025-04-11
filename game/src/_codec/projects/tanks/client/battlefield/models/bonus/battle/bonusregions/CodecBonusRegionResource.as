package _codec.projects.tanks.client.battlefield.models.bonus.battle.bonusregions {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;

  public class CodecBonusRegionResource implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_dropZoneResource:ICodec;
    private var codec_regionType:ICodec;

    public function CodecBonusRegionResource() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_dropZoneResource = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_regionType = param1.getCodec(new EnumCodecInfo(BonusesType,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusRegionResource = new BonusRegionResource();
      local2.dropZoneResource = this.codec_dropZoneResource.decode(param1) as TextureResource;
      local2.regionType = this.codec_regionType.decode(param1) as BonusesType;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusRegionResource = BonusRegionResource(param2);
      this.codec_dropZoneResource.encode(param1,local3.dropZoneResource);
      this.codec_regionType.encode(param1,local3.regionType);
    }
  }
}
