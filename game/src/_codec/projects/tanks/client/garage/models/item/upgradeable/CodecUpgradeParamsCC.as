package _codec.projects.tanks.client.garage.models.item.upgradeable {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;
  import projects.tanks.client.garage.models.item.upgradeable.types.UpgradeParamsData;

  public class CodecUpgradeParamsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currentLevel:ICodec;
    private var codec_itemData:ICodec;
    private var codec_remainingTimeInMS:ICodec;
    private var codec_speedUpDiscount:ICodec;
    private var codec_timeDiscount:ICodec;
    private var codec_upgradeDiscount:ICodec;

    public function CodecUpgradeParamsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currentLevel = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_itemData = param1.getCodec(new TypeCodecInfo(UpgradeParamsData,false));
      this.codec_remainingTimeInMS = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_speedUpDiscount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeDiscount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_upgradeDiscount = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UpgradeParamsCC = new UpgradeParamsCC();
      local2.currentLevel = this.codec_currentLevel.decode(param1) as int;
      local2.itemData = this.codec_itemData.decode(param1) as UpgradeParamsData;
      local2.remainingTimeInMS = this.codec_remainingTimeInMS.decode(param1) as int;
      local2.speedUpDiscount = this.codec_speedUpDiscount.decode(param1) as int;
      local2.timeDiscount = this.codec_timeDiscount.decode(param1) as int;
      local2.upgradeDiscount = this.codec_upgradeDiscount.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UpgradeParamsCC = UpgradeParamsCC(param2);
      this.codec_currentLevel.encode(param1,local3.currentLevel);
      this.codec_itemData.encode(param1,local3.itemData);
      this.codec_remainingTimeInMS.encode(param1,local3.remainingTimeInMS);
      this.codec_speedUpDiscount.encode(param1,local3.speedUpDiscount);
      this.codec_timeDiscount.encode(param1,local3.timeDiscount);
      this.codec_upgradeDiscount.encode(param1,local3.upgradeDiscount);
    }
  }
}
