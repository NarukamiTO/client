package _codec.projects.tanks.client.panel.model.payment.modes.pricerange {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.pricerange.PriceRangeCC;

  public class CodecPriceRangeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_enabled:ICodec;
    private var codec_minimum:ICodec;

    public function CodecPriceRangeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_minimum = param1.getCodec(new TypeCodecInfo(Number,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PriceRangeCC = new PriceRangeCC();
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      local2.minimum = this.codec_minimum.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PriceRangeCC = PriceRangeCC(param2);
      this.codec_enabled.encode(param1,local3.enabled);
      this.codec_minimum.encode(param1,local3.minimum);
    }
  }
}
