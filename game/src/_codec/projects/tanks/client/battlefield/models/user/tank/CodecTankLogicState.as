package _codec.projects.tanks.client.battlefield.models.user.tank {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  public class CodecTankLogicState implements ICodec {
    public function CodecTankLogicState() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankLogicState = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = TankLogicState.NEW;
          break;
        case 1:
          local2 = TankLogicState.OUT_OF_GAME;
          break;
        case 2:
          local2 = TankLogicState.ACTIVATING;
          break;
        case 3:
          local2 = TankLogicState.ACTIVE;
          break;
        case 4:
          local2 = TankLogicState.DEAD;
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
