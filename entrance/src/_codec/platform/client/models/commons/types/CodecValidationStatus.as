package _codec.platform.client.models.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import platform.client.models.commons.types.ValidationStatus;

  public class CodecValidationStatus implements ICodec {
    public function CodecValidationStatus() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ValidationStatus = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ValidationStatus.TOO_SHORT;
          break;
        case 1:
          local2 = ValidationStatus.TOO_LONG;
          break;
        case 2:
          local2 = ValidationStatus.NOT_UNIQUE;
          break;
        case 3:
          local2 = ValidationStatus.NOT_MATCH_PATTERN;
          break;
        case 4:
          local2 = ValidationStatus.FORBIDDEN;
          break;
        case 5:
          local2 = ValidationStatus.CORRECT;
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
