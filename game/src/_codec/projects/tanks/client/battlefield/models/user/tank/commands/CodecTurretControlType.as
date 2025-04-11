package _codec.projects.tanks.client.battlefield.models.user.tank.commands {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public class CodecTurretControlType implements ICodec {
    public function CodecTurretControlType() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TurretControlType = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = TurretControlType.ROTATION_DIRECTION;
          break;
        case 1:
          local2 = TurretControlType.TARGET_ANGLE_LOCAL;
          break;
        case 2:
          local2 = TurretControlType.TARGET_ANGLE_WORLD;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
