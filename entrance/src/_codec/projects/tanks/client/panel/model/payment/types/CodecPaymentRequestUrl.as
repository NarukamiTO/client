package _codec.projects.tanks.client.panel.model.payment.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class CodecPaymentRequestUrl implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_encodeParameters:ICodec;
    private var codec_getRequest:ICodec;
    private var codec_host:ICodec;
    private var codec_parameters:ICodec;

    public function CodecPaymentRequestUrl() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_encodeParameters = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_getRequest = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_host = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_parameters = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(PaymentRequestVariable,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentRequestUrl = new PaymentRequestUrl();
      local2.encodeParameters = this.codec_encodeParameters.decode(param1) as Boolean;
      local2.getRequest = this.codec_getRequest.decode(param1) as Boolean;
      local2.host = this.codec_host.decode(param1) as String;
      local2.parameters = this.codec_parameters.decode(param1) as Vector.<PaymentRequestVariable>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaymentRequestUrl = PaymentRequestUrl(param2);
      this.codec_encodeParameters.encode(param1,local3.encodeParameters);
      this.codec_getRequest.encode(param1,local3.getRequest);
      this.codec_host.encode(param1,local3.host);
      this.codec_parameters.encode(param1,local3.parameters);
    }
  }
}
