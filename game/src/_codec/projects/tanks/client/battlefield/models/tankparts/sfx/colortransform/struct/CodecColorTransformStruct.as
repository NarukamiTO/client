package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Short;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;

  public class CodecColorTransformStruct implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alphaMultiplier:ICodec;
    private var codec_alphaOffset:ICodec;
    private var codec_blueMultiplier:ICodec;
    private var codec_blueOffset:ICodec;
    private var codec_greenMultiplier:ICodec;
    private var codec_greenOffset:ICodec;
    private var codec_redMultiplier:ICodec;
    private var codec_redOffset:ICodec;
    private var codec_t:ICodec;

    public function CodecColorTransformStruct() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alphaMultiplier = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_alphaOffset = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_blueMultiplier = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_blueOffset = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_greenMultiplier = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_greenOffset = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_redMultiplier = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_redOffset = param1.getCodec(new TypeCodecInfo(Short,false));
      this.codec_t = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ColorTransformStruct = new ColorTransformStruct();
      local2.alphaMultiplier = this.codec_alphaMultiplier.decode(param1) as Number;
      local2.alphaOffset = this.codec_alphaOffset.decode(param1) as int;
      local2.blueMultiplier = this.codec_blueMultiplier.decode(param1) as Number;
      local2.blueOffset = this.codec_blueOffset.decode(param1) as int;
      local2.greenMultiplier = this.codec_greenMultiplier.decode(param1) as Number;
      local2.greenOffset = this.codec_greenOffset.decode(param1) as int;
      local2.redMultiplier = this.codec_redMultiplier.decode(param1) as Number;
      local2.redOffset = this.codec_redOffset.decode(param1) as int;
      local2.t = this.codec_t.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ColorTransformStruct = ColorTransformStruct(param2);
      this.codec_alphaMultiplier.encode(param1,local3.alphaMultiplier);
      this.codec_alphaOffset.encode(param1,local3.alphaOffset);
      this.codec_blueMultiplier.encode(param1,local3.blueMultiplier);
      this.codec_blueOffset.encode(param1,local3.blueOffset);
      this.codec_greenMultiplier.encode(param1,local3.greenMultiplier);
      this.codec_greenOffset.encode(param1,local3.greenOffset);
      this.codec_redMultiplier.encode(param1,local3.redMultiplier);
      this.codec_redOffset.encode(param1,local3.redOffset);
      this.codec_t.encode(param1,local3.t);
    }
  }
}
