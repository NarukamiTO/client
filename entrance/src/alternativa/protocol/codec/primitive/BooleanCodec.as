package alternativa.protocol.codec.primitive {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;

  public class BooleanCodec implements ICodec {
    public function BooleanCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeByte(Boolean(param2) ? int(1) : int(0));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.reader.readByte() != 0;
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
