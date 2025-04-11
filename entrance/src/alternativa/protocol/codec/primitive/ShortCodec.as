package alternativa.protocol.codec.primitive {
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class ShortCodec implements IPrimitiveCodec {
    public function ShortCodec() {
      super();
    }

    public function nullValue() : Object {
      return int.MIN_VALUE;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeShort(int(param2));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readShort();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
