package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.common {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecTargetPosition implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_orientation:ICodec;
    private var codec_position:ICodec;
    private var codec_target:ICodec;
    private var codec_turretAngle:ICodec;

    public function CodecTargetPosition() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_orientation = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_target = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_turretAngle = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TargetPosition = new TargetPosition();
      local2.orientation = this.codec_orientation.decode(param1) as Vector3d;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.target = this.codec_target.decode(param1) as IGameObject;
      local2.turretAngle = this.codec_turretAngle.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TargetPosition = TargetPosition(param2);
      this.codec_orientation.encode(param1,local3.orientation);
      this.codec_position.encode(param1,local3.position);
      this.codec_target.encode(param1,local3.target);
      this.codec_turretAngle.encode(param1,local3.turretAngle);
    }
  }
}
