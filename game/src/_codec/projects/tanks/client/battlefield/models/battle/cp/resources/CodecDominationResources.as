package _codec.projects.tanks.client.battlefield.models.battle.cp.resources {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecDominationResources implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bigLetters:ICodec;
    private var codec_blueCircle:ICodec;
    private var codec_bluePedestalTexture:ICodec;
    private var codec_blueRay:ICodec;
    private var codec_blueRayTip:ICodec;
    private var codec_neutralCircle:ICodec;
    private var codec_neutralPedestalTexture:ICodec;
    private var codec_pedestal:ICodec;
    private var codec_redCircle:ICodec;
    private var codec_redPedestalTexture:ICodec;
    private var codec_redRay:ICodec;
    private var codec_redRayTip:ICodec;

    public function CodecDominationResources() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bigLetters = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_blueCircle = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_bluePedestalTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueRayTip = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_neutralCircle = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_neutralPedestalTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_pedestal = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_redCircle = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_redPedestalTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redRayTip = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DominationResources = new DominationResources();
      local2.bigLetters = this.codec_bigLetters.decode(param1) as ImageResource;
      local2.blueCircle = this.codec_blueCircle.decode(param1) as ImageResource;
      local2.bluePedestalTexture = this.codec_bluePedestalTexture.decode(param1) as TextureResource;
      local2.blueRay = this.codec_blueRay.decode(param1) as TextureResource;
      local2.blueRayTip = this.codec_blueRayTip.decode(param1) as TextureResource;
      local2.neutralCircle = this.codec_neutralCircle.decode(param1) as ImageResource;
      local2.neutralPedestalTexture = this.codec_neutralPedestalTexture.decode(param1) as TextureResource;
      local2.pedestal = this.codec_pedestal.decode(param1) as Tanks3DSResource;
      local2.redCircle = this.codec_redCircle.decode(param1) as ImageResource;
      local2.redPedestalTexture = this.codec_redPedestalTexture.decode(param1) as TextureResource;
      local2.redRay = this.codec_redRay.decode(param1) as TextureResource;
      local2.redRayTip = this.codec_redRayTip.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DominationResources = DominationResources(param2);
      this.codec_bigLetters.encode(param1,local3.bigLetters);
      this.codec_blueCircle.encode(param1,local3.blueCircle);
      this.codec_bluePedestalTexture.encode(param1,local3.bluePedestalTexture);
      this.codec_blueRay.encode(param1,local3.blueRay);
      this.codec_blueRayTip.encode(param1,local3.blueRayTip);
      this.codec_neutralCircle.encode(param1,local3.neutralCircle);
      this.codec_neutralPedestalTexture.encode(param1,local3.neutralPedestalTexture);
      this.codec_pedestal.encode(param1,local3.pedestal);
      this.codec_redCircle.encode(param1,local3.redCircle);
      this.codec_redPedestalTexture.encode(param1,local3.redPedestalTexture);
      this.codec_redRay.encode(param1,local3.redRay);
      this.codec_redRayTip.encode(param1,local3.redRayTip);
    }
  }
}
