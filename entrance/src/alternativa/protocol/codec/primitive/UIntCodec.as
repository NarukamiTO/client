package alternativa.protocol.codec.primitive {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class UIntCodec implements ICodec {
    public function UIntCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeUnsignedInt(uint(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readUnsignedInt();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
