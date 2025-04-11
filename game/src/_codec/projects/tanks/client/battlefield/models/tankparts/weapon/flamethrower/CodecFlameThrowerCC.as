package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerCC;

  public class CodecFlameThrowerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_coneAngle:ICodec;
    private var codec_range:ICodec;

    public function CodecFlameThrowerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_coneAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_range = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FlameThrowerCC = new FlameThrowerCC();
      local2.coneAngle = this.codec_coneAngle.decode(param1) as Number;
      local2.range = this.codec_range.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FlameThrowerCC = FlameThrowerCC(param2);
      this.codec_coneAngle.encode(param1,local3.coneAngle);
      this.codec_range.encode(param1,local3.range);
    }
  }
}
