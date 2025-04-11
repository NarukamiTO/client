package _codec.projects.tanks.client.battlefield.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecVector3d implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_x:ICodec;
    private var codec_y:ICodec;
    private var codec_z:ICodec;

    public function CodecVector3d() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_x = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_y = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_z = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Vector3d = new Vector3d();
      local2.x = this.codec_x.decode(param1) as Number;
      local2.y = this.codec_y.decode(param1) as Number;
      local2.z = this.codec_z.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Vector3d = Vector3d(param2);
      this.codec_x.encode(param1,local3.x);
      this.codec_y.encode(param1,local3.y);
      this.codec_z.encode(param1,local3.z);
    }
  }
}
