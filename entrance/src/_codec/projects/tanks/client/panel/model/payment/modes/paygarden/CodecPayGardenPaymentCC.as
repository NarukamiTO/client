package _codec.projects.tanks.client.panel.model.payment.modes.paygarden {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenPaymentCC;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;

  public class CodecPayGardenPaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_productType:ICodec;

    public function CodecPayGardenPaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_productType = param1.getCodec(new EnumCodecInfo(PayGardenProductType,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PayGardenPaymentCC = new PayGardenPaymentCC();
      local2.productType = this.codec_productType.decode(param1) as PayGardenProductType;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PayGardenPaymentCC = PayGardenPaymentCC(param2);
      this.codec_productType.encode(param1,local3.productType);
    }
  }
}
