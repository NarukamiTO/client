package _codec.platform.client.core.general.socialnetwork.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import platform.client.core.general.socialnetwork.types.Gender;

  public class CodecGender implements ICodec {
    public function CodecGender() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Gender = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = Gender.MALE;
          break;
        case 1:
          local2 = Gender.FEMALE;
          break;
        case 2:
          local2 = Gender.NONE;
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
