package _codec.projects.tanks.client.commons.models.coloring {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.commons.models.coloring.ColoringCC;

  public class CodecColoringCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_animatedColoring:ICodec;
    private var codec_coloring:ICodec;

    public function CodecColoringCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_animatedColoring = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,true));
      this.codec_coloring = param1.getCodec(new TypeCodecInfo(TextureResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ColoringCC = new ColoringCC();
      local2.animatedColoring = this.codec_animatedColoring.decode(param1) as MultiframeTextureResource;
      local2.coloring = this.codec_coloring.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ColoringCC = ColoringCC(param2);
      this.codec_animatedColoring.encode(param1,local3.animatedColoring);
      this.codec_coloring.encode(param1,local3.coloring);
    }
  }
}
