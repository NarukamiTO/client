package _codec.projects.tanks.client.garage.models.item.itempersonaldiscount {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.DiscountData;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.ItemPersonalDiscountCC;

  public class CodecItemPersonalDiscountCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_discounts:ICodec;

    public function CodecItemPersonalDiscountCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_discounts = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(DiscountData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemPersonalDiscountCC = new ItemPersonalDiscountCC();
      local2.discounts = this.codec_discounts.decode(param1) as Vector.<DiscountData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemPersonalDiscountCC = ItemPersonalDiscountCC(param2);
      this.codec_discounts.encode(param1,local3.discounts);
    }
  }
}
