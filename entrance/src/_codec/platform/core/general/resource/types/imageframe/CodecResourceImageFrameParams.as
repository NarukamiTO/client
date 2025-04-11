package _codec.platform.core.general.resource.types.imageframe {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Short;
  import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;

  public class CodecResourceImageFrameParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_fps:ICodec;
    private var codec_frameHeight:ICodec;
    private var codec_frameWidth:ICodec;
    private var codec_imageHeight:ICodec;
    private var codec_imageWidth:ICodec;
    private var codec_numFrames:ICodec;

    public function CodecResourceImageFrameParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_fps = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_frameHeight = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_frameWidth = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_imageHeight = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_imageWidth = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_numFrames = param1.getCodec(new TypeCodecInfo(Short,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ResourceImageFrameParams = new ResourceImageFrameParams();
      local2.fps = this.codec_fps.decode(param1) as Number;
      local2.frameHeight = this.codec_frameHeight.decode(param1) as int;
      local2.frameWidth = this.codec_frameWidth.decode(param1) as int;
      local2.imageHeight = this.codec_imageHeight.decode(param1) as int;
      local2.imageWidth = this.codec_imageWidth.decode(param1) as int;
      local2.numFrames = this.codec_numFrames.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ResourceImageFrameParams = ResourceImageFrameParams(param2);
      this.codec_fps.encode(param1,local3.fps);
      this.codec_frameHeight.encode(param1,local3.frameHeight);
      this.codec_frameWidth.encode(param1,local3.frameWidth);
      this.codec_imageHeight.encode(param1,local3.imageHeight);
      this.codec_imageWidth.encode(param1,local3.imageWidth);
      this.codec_numFrames.encode(param1,local3.numFrames);
    }
  }
}
