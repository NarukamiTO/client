package alternativa.protocol.codec.primitive {
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class ByteCodec implements IPrimitiveCodec {
    public function ByteCodec() {
      super();
    }

    public function nullValue() : Object {
      return int.MAX_VALUE;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeByte(int(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readByte();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
