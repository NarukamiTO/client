package _codec.projects.tanks.client.panel.model.payment {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.PaymentPackage;

  public class CodecPaymentPackage implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_amountCrystals:ICodec;
    private var codec_bonusCrystals:ICodec;
    private var codec_currency:ICodec;
    private var codec_premiumDurationInDays:ICodec;
    private var codec_price:ICodec;

    public function CodecPaymentPackage() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_amountCrystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_bonusCrystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_currency = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_premiumDurationInDays = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_price = param1.getCodec(new TypeCodecInfo(Number,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentPackage = new PaymentPackage();
      local2.amountCrystals = this.codec_amountCrystals.decode(param1) as int;
      local2.bonusCrystals = this.codec_bonusCrystals.decode(param1) as int;
      local2.currency = this.codec_currency.decode(param1) as String;
      local2.premiumDurationInDays = this.codec_premiumDurationInDays.decode(param1) as int;
      local2.price = this.codec_price.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaymentPackage = PaymentPackage(param2);
      this.codec_amountCrystals.encode(param1,local3.amountCrystals);
      this.codec_bonusCrystals.encode(param1,local3.bonusCrystals);
      this.codec_currency.encode(param1,local3.currency);
      this.codec_premiumDurationInDays.encode(param1,local3.premiumDurationInDays);
      this.codec_price.encode(param1,local3.price);
    }
  }
}
