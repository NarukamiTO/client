package _codec.projects.tanks.client.panel.model.payment.modes.braintree {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.braintree.BraintreePaymentCC;

  public class CodecBraintreePaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_payPal:ICodec;

    public function CodecBraintreePaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_payPal = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BraintreePaymentCC = new BraintreePaymentCC();
      local2.payPal = this.codec_payPal.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BraintreePaymentCC = BraintreePaymentCC(param2);
      this.codec_payPal.encode(param1,local3.payPal);
    }
  }
}
