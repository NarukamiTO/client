package _codec.projects.tanks.client.panel.model.payment.modes.android {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.android.PurchaseData;

  public class CodecPurchaseData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currency:ICodec;
    private var codec_itemId:ICodec;
    private var codec_token:ICodec;

    public function CodecPurchaseData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currency = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_itemId = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_token = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PurchaseData = new PurchaseData();
      local2.currency = this.codec_currency.decode(param1) as String;
      local2.itemId = this.codec_itemId.decode(param1) as String;
      local2.token = this.codec_token.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PurchaseData = PurchaseData(param2);
      this.codec_currency.encode(param1,local3.currency);
      this.codec_itemId.encode(param1,local3.itemId);
      this.codec_token.encode(param1,local3.token);
    }
  }
}
