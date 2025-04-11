package _codec.projects.tanks.client.battlefield.models.tankparts.armor.chassis.tracked {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.armor.chassis.tracked.TrackedChassisCC;

  public class CodecTrackedChassisCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_damping:ICodec;

    public function CodecTrackedChassisCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_damping = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TrackedChassisCC = new TrackedChassisCC();
      local2.damping = this.codec_damping.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TrackedChassisCC = TrackedChassisCC(param2);
      this.codec_damping.encode(param1,local3.damping);
    }
  }
}
