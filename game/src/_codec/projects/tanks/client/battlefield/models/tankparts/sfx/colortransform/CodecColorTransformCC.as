package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.colortransform {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.ColorTransformCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;

  public class CodecColorTransformCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_colorTransforms:ICodec;

    public function CodecColorTransformCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_colorTransforms = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ColorTransformStruct,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ColorTransformCC = new ColorTransformCC();
      local2.colorTransforms = this.codec_colorTransforms.decode(param1) as Vector.<ColorTransformStruct>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ColorTransformCC = ColorTransformCC(param2);
      this.codec_colorTransforms.encode(param1,local3.colorTransforms);
    }
  }
}
