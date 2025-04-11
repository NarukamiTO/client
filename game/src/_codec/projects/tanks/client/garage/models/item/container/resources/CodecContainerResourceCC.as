package _codec.projects.tanks.client.garage.models.item.container.resources {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;

  public class CodecContainerResourceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_fiveBoxImage:ICodec;
    private var codec_fiveBoxLightImage:ICodec;
    private var codec_fiveBoxOpenedImage:ICodec;
    private var codec_oneBoxImage:ICodec;
    private var codec_oneBoxLightImage:ICodec;
    private var codec_oneBoxOpenedImage:ICodec;
    private var codec_threeBoxImage:ICodec;
    private var codec_threeBoxLightImage:ICodec;
    private var codec_threeBoxOpenedImage:ICodec;

    public function CodecContainerResourceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_fiveBoxImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_fiveBoxLightImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_fiveBoxOpenedImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_oneBoxImage = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_oneBoxLightImage = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_oneBoxOpenedImage = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_threeBoxImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_threeBoxLightImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_threeBoxOpenedImage = param1.getCodec(new TypeCodecInfo(ImageResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ContainerResourceCC = new ContainerResourceCC();
      local2.fiveBoxImage = this.codec_fiveBoxImage.decode(param1) as ImageResource;
      local2.fiveBoxLightImage = this.codec_fiveBoxLightImage.decode(param1) as ImageResource;
      local2.fiveBoxOpenedImage = this.codec_fiveBoxOpenedImage.decode(param1) as ImageResource;
      local2.oneBoxImage = this.codec_oneBoxImage.decode(param1) as ImageResource;
      local2.oneBoxLightImage = this.codec_oneBoxLightImage.decode(param1) as ImageResource;
      local2.oneBoxOpenedImage = this.codec_oneBoxOpenedImage.decode(param1) as ImageResource;
      local2.threeBoxImage = this.codec_threeBoxImage.decode(param1) as ImageResource;
      local2.threeBoxLightImage = this.codec_threeBoxLightImage.decode(param1) as ImageResource;
      local2.threeBoxOpenedImage = this.codec_threeBoxOpenedImage.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ContainerResourceCC = ContainerResourceCC(param2);
      this.codec_fiveBoxImage.encode(param1,local3.fiveBoxImage);
      this.codec_fiveBoxLightImage.encode(param1,local3.fiveBoxLightImage);
      this.codec_fiveBoxOpenedImage.encode(param1,local3.fiveBoxOpenedImage);
      this.codec_oneBoxImage.encode(param1,local3.oneBoxImage);
      this.codec_oneBoxLightImage.encode(param1,local3.oneBoxLightImage);
      this.codec_oneBoxOpenedImage.encode(param1,local3.oneBoxOpenedImage);
      this.codec_threeBoxImage.encode(param1,local3.threeBoxImage);
      this.codec_threeBoxLightImage.encode(param1,local3.threeBoxLightImage);
      this.codec_threeBoxOpenedImage.encode(param1,local3.threeBoxOpenedImage);
    }
  }
}
