package _codec.projects.tanks.client.panel.model.payment.modes {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.payment.modes.PayModeCC;

  public class CodecPayModeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_customManualDescription:ICodec;
    private var codec_description:ICodec;
    private var codec_image:ICodec;
    private var codec_name:ICodec;
    private var codec_order:ICodec;

    public function CodecPayModeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_customManualDescription = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_order = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PayModeCC = new PayModeCC();
      local2.customManualDescription = this.codec_customManualDescription.decode(param1) as String;
      local2.description = this.codec_description.decode(param1) as String;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.name = this.codec_name.decode(param1) as String;
      local2.order = this.codec_order.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PayModeCC = PayModeCC(param2);
      this.codec_customManualDescription.encode(param1,local3.customManualDescription);
      this.codec_description.encode(param1,local3.description);
      this.codec_image.encode(param1,local3.image);
      this.codec_name.encode(param1,local3.name);
      this.codec_order.encode(param1,local3.order);
    }
  }
}
