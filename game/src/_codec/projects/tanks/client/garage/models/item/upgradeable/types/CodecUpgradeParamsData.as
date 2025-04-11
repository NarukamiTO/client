package _codec.projects.tanks.client.garage.models.item.upgradeable.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.UpgradeParamsData;

  public class CodecUpgradeParamsData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_finalUpgradePrice:ICodec;
    private var codec_initialUpgradePrice:ICodec;
    private var codec_properties:ICodec;
    private var codec_speedUpCoeff:ICodec;
    private var codec_upgradeLevelsCount:ICodec;
    private var codec_upgradeTimeCoeff:ICodec;

    public function CodecUpgradeParamsData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_finalUpgradePrice = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_initialUpgradePrice = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_properties = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(GaragePropertyParams,false),false,1));
      this.codec_speedUpCoeff = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_upgradeLevelsCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_upgradeTimeCoeff = param1.getCodec(new TypeCodecInfo(Number,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UpgradeParamsData = new UpgradeParamsData();
      local2.finalUpgradePrice = this.codec_finalUpgradePrice.decode(param1) as int;
      local2.initialUpgradePrice = this.codec_initialUpgradePrice.decode(param1) as int;
      local2.properties = this.codec_properties.decode(param1) as Vector.<GaragePropertyParams>;
      local2.speedUpCoeff = this.codec_speedUpCoeff.decode(param1) as Number;
      local2.upgradeLevelsCount = this.codec_upgradeLevelsCount.decode(param1) as int;
      local2.upgradeTimeCoeff = this.codec_upgradeTimeCoeff.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UpgradeParamsData = UpgradeParamsData(param2);
      this.codec_finalUpgradePrice.encode(param1,local3.finalUpgradePrice);
      this.codec_initialUpgradePrice.encode(param1,local3.initialUpgradePrice);
      this.codec_properties.encode(param1,local3.properties);
      this.codec_speedUpCoeff.encode(param1,local3.speedUpCoeff);
      this.codec_upgradeLevelsCount.encode(param1,local3.upgradeLevelsCount);
      this.codec_upgradeTimeCoeff.encode(param1,local3.upgradeTimeCoeff);
    }
  }
}
