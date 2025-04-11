package _codec.projects.tanks.client.panel.model.shop.kitview {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.kitview.KitViewResourceCC;

  public class CodecKitViewResourceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buttonKit:ICodec;
    private var codec_buttonKitOver:ICodec;

    public function CodecKitViewResourceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buttonKit = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_buttonKitOver = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitViewResourceCC = new KitViewResourceCC();
      local2.buttonKit = this.codec_buttonKit.decode(param1) as ImageResource;
      local2.buttonKitOver = this.codec_buttonKitOver.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitViewResourceCC = KitViewResourceCC(param2);
      this.codec_buttonKit.encode(param1,local3.buttonKit);
      this.codec_buttonKitOver.encode(param1,local3.buttonKitOver);
    }
  }
}
