package alternativa.protocol.codec.primitive {
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class DoubleCodec implements IPrimitiveCodec {
    public function DoubleCodec() {
      super();
    }

    public function nullValue() : Object {
      return Number.NEGATIVE_INFINITY;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeDouble(Number(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readDouble();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
