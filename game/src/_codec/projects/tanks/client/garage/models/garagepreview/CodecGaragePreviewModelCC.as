package _codec.projects.tanks.client.garage.models.garagepreview {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.garage.models.garagepreview.GaragePreviewModelCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecGaragePreviewModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_cameraAltitude:ICodec;
    private var codec_cameraDistance:ICodec;
    private var codec_cameraFov:ICodec;
    private var codec_cameraPitch:ICodec;
    private var codec_garageBox:ICodec;
    private var codec_hasBatteries:ICodec;
    private var codec_skyboxFrontSide:ICodec;

    public function CodecGaragePreviewModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_cameraAltitude = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraFov = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_cameraPitch = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_garageBox = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_hasBatteries = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_skyboxFrontSide = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GaragePreviewModelCC = new GaragePreviewModelCC();
      local2.cameraAltitude = this.codec_cameraAltitude.decode(param1) as Number;
      local2.cameraDistance = this.codec_cameraDistance.decode(param1) as Number;
      local2.cameraFov = this.codec_cameraFov.decode(param1) as Number;
      local2.cameraPitch = this.codec_cameraPitch.decode(param1) as Number;
      local2.garageBox = this.codec_garageBox.decode(param1) as Tanks3DSResource;
      local2.hasBatteries = this.codec_hasBatteries.decode(param1) as Boolean;
      local2.skyboxFrontSide = this.codec_skyboxFrontSide.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GaragePreviewModelCC = GaragePreviewModelCC(param2);
      this.codec_cameraAltitude.encode(param1,local3.cameraAltitude);
      this.codec_cameraDistance.encode(param1,local3.cameraDistance);
      this.codec_cameraFov.encode(param1,local3.cameraFov);
      this.codec_cameraPitch.encode(param1,local3.cameraPitch);
      this.codec_garageBox.encode(param1,local3.garageBox);
      this.codec_hasBatteries.encode(param1,local3.hasBatteries);
      this.codec_skyboxFrontSide.encode(param1,local3.skyboxFrontSide);
    }
  }
}
