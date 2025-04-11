package _codec.projects.tanks.client.garage.models.item.itempersonaldiscount {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.itempersonaldiscount.DiscountData;

  public class CodecDiscountData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_discountForPercent:ICodec;
    private var codec_duration:ICodec;

    public function CodecDiscountData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_discountForPercent = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_duration = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DiscountData = new DiscountData();
      local2.discountForPercent = this.codec_discountForPercent.decode(param1) as Number;
      local2.duration = this.codec_duration.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DiscountData = DiscountData(param2);
      this.codec_discountForPercent.encode(param1,local3.discountForPercent);
      this.codec_duration.encode(param1,local3.duration);
    }
  }
}
