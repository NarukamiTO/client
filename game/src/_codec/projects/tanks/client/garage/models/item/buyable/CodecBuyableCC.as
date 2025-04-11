package _codec.projects.tanks.client.garage.models.item.buyable {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.buyable.BuyableCC;

  public class CodecBuyableCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buyable:ICodec;
    private var codec_priceWithoutDiscount:ICodec;

    public function CodecBuyableCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buyable = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_priceWithoutDiscount = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BuyableCC = new BuyableCC();
      local2.buyable = this.codec_buyable.decode(param1) as Boolean;
      local2.priceWithoutDiscount = this.codec_priceWithoutDiscount.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BuyableCC = BuyableCC(param2);
      this.codec_buyable.encode(param1,local3.buyable);
      this.codec_priceWithoutDiscount.encode(param1,local3.priceWithoutDiscount);
    }
  }
}
