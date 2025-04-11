package _codec.projects.tanks.client.panel.model.payment.modes {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;

  public class CodecPaymentRequestVariable implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_value:ICodec;
    private var codec_variable:ICodec;

    public function CodecPaymentRequestVariable() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_value = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_variable = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentRequestVariable = new PaymentRequestVariable();
      local2.value = this.codec_value.decode(param1) as String;
      local2.variable = this.codec_variable.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaymentRequestVariable = PaymentRequestVariable(param2);
      this.codec_value.encode(param1,local3.value);
      this.codec_variable.encode(param1,local3.variable);
    }
  }
}
