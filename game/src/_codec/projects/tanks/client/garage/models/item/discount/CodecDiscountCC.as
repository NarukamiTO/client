package _codec.projects.tanks.client.garage.models.item.discount {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.garage.models.item.discount.DiscountCC;

  public class CodecDiscountCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_discount:ICodec;
    private var codec_timeLeftInSeconds:ICodec;
    private var codec_timeToStartInSeconds:ICodec;

    public function CodecDiscountCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_discount = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_timeLeftInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeToStartInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DiscountCC = new DiscountCC();
      local2.discount = this.codec_discount.decode(param1) as Number;
      local2.timeLeftInSeconds = this.codec_timeLeftInSeconds.decode(param1) as int;
      local2.timeToStartInSeconds = this.codec_timeToStartInSeconds.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DiscountCC = DiscountCC(param2);
      this.codec_discount.encode(param1,local3.discount);
      this.codec_timeLeftInSeconds.encode(param1,local3.timeLeftInSeconds);
      this.codec_timeToStartInSeconds.encode(param1,local3.timeToStartInSeconds);
    }
  }
}
