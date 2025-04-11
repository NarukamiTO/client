package alternativa.protocol.codec.primitive {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class UByteCodec implements ICodec {
    public function UByteCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeUnsignedInt(uint(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readUnsignedByte();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
