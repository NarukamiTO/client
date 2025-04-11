package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.turret {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretCC;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class CodecRotatingTurretCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_turretState:ICodec;

    public function CodecRotatingTurretCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_turretState = param1.getCodec(new TypeCodecInfo(TurretStateCommand,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RotatingTurretCC = new RotatingTurretCC();
      local2.turretState = this.codec_turretState.decode(param1) as TurretStateCommand;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RotatingTurretCC = RotatingTurretCC(param2);
      this.codec_turretState.encode(param1,local3.turretState);
    }
  }
}
