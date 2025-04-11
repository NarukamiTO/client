package _codec.projects.tanks.client.panel.model.payment {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;
  import projects.tanks.client.panel.model.payment.PaymentPackage;

  public class CodecCrystalsPaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_accountId:ICodec;
    private var codec_calculatorEnabled:ICodec;
    private var codec_crystalCost:ICodec;
    private var codec_defaultAmountOfCrystals:ICodec;
    private var codec_greaterMaximumCrystalsMessage:ICodec;
    private var codec_greaterMaximumMoneyMessage:ICodec;
    private var codec_lessMinimumCrystalsMessage:ICodec;
    private var codec_lessMinimumMoneyMessage:ICodec;
    private var codec_manualDescription:ICodec;
    private var codec_paymentPackages:ICodec;

    public function CodecCrystalsPaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_accountId = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_calculatorEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_crystalCost = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_defaultAmountOfCrystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_greaterMaximumCrystalsMessage = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_greaterMaximumMoneyMessage = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_lessMinimumCrystalsMessage = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_lessMinimumMoneyMessage = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_manualDescription = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_paymentPackages = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(PaymentPackage,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CrystalsPaymentCC = new CrystalsPaymentCC();
      local2.accountId = this.codec_accountId.decode(param1) as String;
      local2.calculatorEnabled = this.codec_calculatorEnabled.decode(param1) as Boolean;
      local2.crystalCost = this.codec_crystalCost.decode(param1) as Number;
      local2.defaultAmountOfCrystals = this.codec_defaultAmountOfCrystals.decode(param1) as int;
      local2.greaterMaximumCrystalsMessage = this.codec_greaterMaximumCrystalsMessage.decode(param1) as String;
      local2.greaterMaximumMoneyMessage = this.codec_greaterMaximumMoneyMessage.decode(param1) as String;
      local2.lessMinimumCrystalsMessage = this.codec_lessMinimumCrystalsMessage.decode(param1) as String;
      local2.lessMinimumMoneyMessage = this.codec_lessMinimumMoneyMessage.decode(param1) as String;
      local2.manualDescription = this.codec_manualDescription.decode(param1) as String;
      local2.paymentPackages = this.codec_paymentPackages.decode(param1) as Vector.<PaymentPackage>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CrystalsPaymentCC = CrystalsPaymentCC(param2);
      this.codec_accountId.encode(param1,local3.accountId);
      this.codec_calculatorEnabled.encode(param1,local3.calculatorEnabled);
      this.codec_crystalCost.encode(param1,local3.crystalCost);
      this.codec_defaultAmountOfCrystals.encode(param1,local3.defaultAmountOfCrystals);
      this.codec_greaterMaximumCrystalsMessage.encode(param1,local3.greaterMaximumCrystalsMessage);
      this.codec_greaterMaximumMoneyMessage.encode(param1,local3.greaterMaximumMoneyMessage);
      this.codec_lessMinimumCrystalsMessage.encode(param1,local3.lessMinimumCrystalsMessage);
      this.codec_lessMinimumMoneyMessage.encode(param1,local3.lessMinimumMoneyMessage);
      this.codec_manualDescription.encode(param1,local3.manualDescription);
      this.codec_paymentPackages.encode(param1,local3.paymentPackages);
    }
  }
}
