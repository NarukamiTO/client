package _codec.projects.tanks.client.panel.model.battlepass.purchasenotifier {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.battlepass.purchasenotifier.BattlePassPurchaseNotifierCC;

  public class CodecBattlePassPurchaseNotifierCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_purchased:ICodec;

    public function CodecBattlePassPurchaseNotifierCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_purchased = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattlePassPurchaseNotifierCC = new BattlePassPurchaseNotifierCC();
      local2.purchased = this.codec_purchased.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattlePassPurchaseNotifierCC = BattlePassPurchaseNotifierCC(param2);
      this.codec_purchased.encode(param1,local3.purchased);
    }
  }
}
