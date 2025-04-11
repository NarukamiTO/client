package _codec.projects.tanks.client.panel.model.payment.modes.terminal {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalInstance;

  public class CodecTerminalInstance implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_image:ICodec;
    private var codec_url:ICodec;

    public function CodecTerminalInstance() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_url = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TerminalInstance = new TerminalInstance();
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.url = this.codec_url.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TerminalInstance = TerminalInstance(param2);
      this.codec_image.encode(param1,local3.image);
      this.codec_url.encode(param1,local3.url);
    }
  }
}
