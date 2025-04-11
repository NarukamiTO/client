package _codec.projects.tanks.client.panel.model.payment.panel {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.panel.PaymentButtonCC;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class CodecPaymentButtonCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_enabledFullPayment:ICodec;
    private var codec_paymentUrl:ICodec;

    public function CodecPaymentButtonCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_enabledFullPayment = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_paymentUrl = param1.getCodec(new TypeCodecInfo(PaymentRequestUrl,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentButtonCC = new PaymentButtonCC();
      local2.enabledFullPayment = this.codec_enabledFullPayment.decode(param1) as Boolean;
      local2.paymentUrl = this.codec_paymentUrl.decode(param1) as PaymentRequestUrl;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaymentButtonCC = PaymentButtonCC(param2);
      this.codec_enabledFullPayment.encode(param1,local3.enabledFullPayment);
      this.codec_paymentUrl.encode(param1,local3.paymentUrl);
    }
  }
}
