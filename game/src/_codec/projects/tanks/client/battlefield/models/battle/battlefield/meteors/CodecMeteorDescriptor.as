package _codec.projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorDescriptor;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecMeteorDescriptor implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_groundPosition:ICodec;
    private var codec_lifeTimeMs:ICodec;
    private var codec_timeToFlyMs:ICodec;
    private var codec_upperPosition:ICodec;

    public function CodecMeteorDescriptor() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_groundPosition = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_lifeTimeMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeToFlyMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_upperPosition = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MeteorDescriptor = new MeteorDescriptor();
      local2.groundPosition = this.codec_groundPosition.decode(param1) as Vector3d;
      local2.lifeTimeMs = this.codec_lifeTimeMs.decode(param1) as int;
      local2.timeToFlyMs = this.codec_timeToFlyMs.decode(param1) as int;
      local2.upperPosition = this.codec_upperPosition.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MeteorDescriptor = MeteorDescriptor(param2);
      this.codec_groundPosition.encode(param1,local3.groundPosition);
      this.codec_lifeTimeMs.encode(param1,local3.lifeTimeMs);
      this.codec_timeToFlyMs.encode(param1,local3.timeToFlyMs);
      this.codec_upperPosition.encode(param1,local3.upperPosition);
    }
  }
}
