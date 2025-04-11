package _codec.projects.tanks.client.entrance.model.users.antiaddiction {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.entrance.model.users.antiaddiction.ChangeIdNumberResult;

  public class CodecChangeIdNumberResult implements ICodec {
    public function CodecChangeIdNumberResult() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChangeIdNumberResult = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ChangeIdNumberResult.OK;
          break;
        case 1:
          local2 = ChangeIdNumberResult.ID_IS_ALREADY_CORRECT;
          break;
        case 2:
          local2 = ChangeIdNumberResult.ID_IS_INCORRECT;
          break;
        case 3:
          local2 = ChangeIdNumberResult.NAME_IS_INCORRECT;
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
