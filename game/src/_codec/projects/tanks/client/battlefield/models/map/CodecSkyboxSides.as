package _codec.projects.tanks.client.battlefield.models.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;

  public class CodecSkyboxSides implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_back:ICodec;
    private var codec_bottom:ICodec;
    private var codec_front:ICodec;
    private var codec_left:ICodec;
    private var codec_right:ICodec;
    private var codec_top:ICodec;

    public function CodecSkyboxSides() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_back = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bottom = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_front = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_left = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_right = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_top = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SkyboxSides = new SkyboxSides();
      local2.back = this.codec_back.decode(param1) as TextureResource;
      local2.bottom = this.codec_bottom.decode(param1) as TextureResource;
      local2.front = this.codec_front.decode(param1) as TextureResource;
      local2.left = this.codec_left.decode(param1) as TextureResource;
      local2.right = this.codec_right.decode(param1) as TextureResource;
      local2.top = this.codec_top.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SkyboxSides = SkyboxSides(param2);
      this.codec_back.encode(param1,local3.back);
      this.codec_bottom.encode(param1,local3.bottom);
      this.codec_front.encode(param1,local3.front);
      this.codec_left.encode(param1,local3.left);
      this.codec_right.encode(param1,local3.right);
      this.codec_top.encode(param1,local3.top);
    }
  }
}
