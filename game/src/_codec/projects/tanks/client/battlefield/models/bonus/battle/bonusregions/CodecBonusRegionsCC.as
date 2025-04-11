package _codec.projects.tanks.client.battlefield.models.bonus.battle.bonusregions {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionsCC;

  public class CodecBonusRegionsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonusRegionResources:ICodec;
    private var codec_bonusRegions:ICodec;

    public function CodecBonusRegionsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonusRegionResources = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusRegionResource,false),false,1));
      this.codec_bonusRegions = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusRegionData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusRegionsCC = new BonusRegionsCC();
      local2.bonusRegionResources = this.codec_bonusRegionResources.decode(param1) as Vector.<BonusRegionResource>;
      local2.bonusRegions = this.codec_bonusRegions.decode(param1) as Vector.<BonusRegionData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusRegionsCC = BonusRegionsCC(param2);
      this.codec_bonusRegionResources.encode(param1,local3.bonusRegionResources);
      this.codec_bonusRegions.encode(param1,local3.bonusRegions);
    }
  }
}
