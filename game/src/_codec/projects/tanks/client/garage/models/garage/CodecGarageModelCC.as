package _codec.projects.tanks.client.garage.models.garage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.garage.GarageModelCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecGarageModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_cameraAltitude:ICodec;
    private var codec_cameraDistance:ICodec;
    private var codec_cameraFov:ICodec;
    private var codec_cameraPitch:ICodec;
    private var codec_garageBox:ICodec;
    private var codec_hideLinks:ICodec;
    private var codec_mountableCategories:ICodec;
    private var codec_skyboxBackSide:ICodec;
    private var codec_skyboxBottomSide:ICodec;
    private var codec_skyboxFrontSide:ICodec;
    private var codec_skyboxLeftSide:ICodec;
    private var codec_skyboxRightSide:ICodec;
    private var codec_skyboxTopSide:ICodec;

    public function CodecGarageModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_cameraAltitude = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraFov = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraPitch = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_garageBox = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_hideLinks = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_mountableCategories = param1.getCodec(new CollectionCodecInfo(new EnumCodecInfo(ItemCategoryEnum,false),false,1));
      this.codec_skyboxBackSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_skyboxBottomSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_skyboxFrontSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_skyboxLeftSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_skyboxRightSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_skyboxTopSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GarageModelCC = new GarageModelCC();
      local2.cameraAltitude = this.codec_cameraAltitude.decode(param1) as Number;
      local2.cameraDistance = this.codec_cameraDistance.decode(param1) as Number;
      local2.cameraFov = this.codec_cameraFov.decode(param1) as Number;
      local2.cameraPitch = this.codec_cameraPitch.decode(param1) as Number;
      local2.garageBox = this.codec_garageBox.decode(param1) as Tanks3DSResource;
      local2.hideLinks = this.codec_hideLinks.decode(param1) as Boolean;
      local2.mountableCategories = this.codec_mountableCategories.decode(param1) as Vector.<ItemCategoryEnum>;
      local2.skyboxBackSide = this.codec_skyboxBackSide.decode(param1) as TextureResource;
      local2.skyboxBottomSide = this.codec_skyboxBottomSide.decode(param1) as TextureResource;
      local2.skyboxFrontSide = this.codec_skyboxFrontSide.decode(param1) as TextureResource;
      local2.skyboxLeftSide = this.codec_skyboxLeftSide.decode(param1) as TextureResource;
      local2.skyboxRightSide = this.codec_skyboxRightSide.decode(param1) as TextureResource;
      local2.skyboxTopSide = this.codec_skyboxTopSide.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GarageModelCC = GarageModelCC(param2);
      this.codec_cameraAltitude.encode(param1,local3.cameraAltitude);
      this.codec_cameraDistance.encode(param1,local3.cameraDistance);
      this.codec_cameraFov.encode(param1,local3.cameraFov);
      this.codec_cameraPitch.encode(param1,local3.cameraPitch);
      this.codec_garageBox.encode(param1,local3.garageBox);
      this.codec_hideLinks.encode(param1,local3.hideLinks);
      this.codec_mountableCategories.encode(param1,local3.mountableCategories);
      this.codec_skyboxBackSide.encode(param1,local3.skyboxBackSide);
      this.codec_skyboxBottomSide.encode(param1,local3.skyboxBottomSide);
      this.codec_skyboxFrontSide.encode(param1,local3.skyboxFrontSide);
      this.codec_skyboxLeftSide.encode(param1,local3.skyboxLeftSide);
      this.codec_skyboxRightSide.encode(param1,local3.skyboxRightSide);
      this.codec_skyboxTopSide.encode(param1,local3.skyboxTopSide);
    }
  }
}
