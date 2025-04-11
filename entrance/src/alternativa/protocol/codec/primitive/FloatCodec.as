package alternativa.protocol.codec.primitive {
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class FloatCodec implements IPrimitiveCodec {
    public function FloatCodec() {
      super();
    }

    public function nullValue() : Object {
      return Number.NEGATIVE_INFINITY;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeFloat(Number(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readFloat();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
