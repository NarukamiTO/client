package _codec.projects.tanks.client.panel.model.shop.clientlayoutkit.entity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.entity.BundleImage;

  public class CodecBundleImage implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_height:ICodec;
    private var codec_image:ICodec;
    private var codec_positionPercentX:ICodec;
    private var codec_positionPercentY:ICodec;

    public function CodecBundleImage() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_height = param1.getCodec(new TypeCodecInfo(int,true));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_positionPercentX = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_positionPercentY = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BundleImage = new BundleImage();
      local2.height = this.codec_height.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.positionPercentX = this.codec_positionPercentX.decode(param1) as int;
      local2.positionPercentY = this.codec_positionPercentY.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BundleImage = BundleImage(param2);
      this.codec_height.encode(param1,local3.height);
      this.codec_image.encode(param1,local3.image);
      this.codec_positionPercentX.encode(param1,local3.positionPercentX);
      this.codec_positionPercentY.encode(param1,local3.positionPercentY);
    }
  }
}
