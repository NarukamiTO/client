package alternativa.protocol.codec.primitive {
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class IntCodec implements IPrimitiveCodec {
    public function IntCodec() {
      super();
    }

    public function nullValue() : Object {
      return int.MIN_VALUE;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeInt(int(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readInt();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
