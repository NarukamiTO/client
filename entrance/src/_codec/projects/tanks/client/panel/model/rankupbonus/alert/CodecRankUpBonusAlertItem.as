package _codec.projects.tanks.client.panel.model.rankupbonus.alert {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.rankupbonus.alert.RankUpBonusAlertItem;

  public class CodecRankUpBonusAlertItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_accruedBonusCrystals:ICodec;
    private var codec_alertPictureUrl:ICodec;

    public function CodecRankUpBonusAlertItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_accruedBonusCrystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_alertPictureUrl = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankUpBonusAlertItem = new RankUpBonusAlertItem();
      local2.accruedBonusCrystals = this.codec_accruedBonusCrystals.decode(param1) as int;
      local2.alertPictureUrl = this.codec_alertPictureUrl.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankUpBonusAlertItem = RankUpBonusAlertItem(param2);
      this.codec_accruedBonusCrystals.encode(param1,local3.accruedBonusCrystals);
      this.codec_alertPictureUrl.encode(param1,local3.alertPictureUrl);
    }
  }
}
