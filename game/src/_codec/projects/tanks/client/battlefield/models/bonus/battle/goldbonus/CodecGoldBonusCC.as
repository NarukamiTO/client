package _codec.projects.tanks.client.battlefield.models.bonus.battle.goldbonus {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.GoldBonusCC;

  public class CodecGoldBonusCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_regionsData:ICodec;

    public function CodecGoldBonusCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_regionsData = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusRegionData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GoldBonusCC = new GoldBonusCC();
      local2.regionsData = this.codec_regionsData.decode(param1) as Vector.<BonusRegionData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GoldBonusCC = GoldBonusCC(param2);
      this.codec_regionsData.encode(param1,local3.regionsData);
    }
  }
}
