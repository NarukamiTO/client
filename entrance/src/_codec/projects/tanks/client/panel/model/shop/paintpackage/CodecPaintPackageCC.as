package _codec.projects.tanks.client.panel.model.shop.paintpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.paintpackage.PaintPackageCC;

  public class CodecPaintPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_description:ICodec;
    private var codec_name:ICodec;

    public function CodecPaintPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaintPackageCC = new PaintPackageCC();
      local2.description = this.codec_description.decode(param1) as String;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaintPackageCC = PaintPackageCC(param2);
      this.codec_description.encode(param1,local3.description);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
