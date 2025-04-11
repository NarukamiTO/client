package alternativa.protocol.codec.primitive {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;

  public class LongCodec implements ICodec {
    public function LongCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      param1.writer.writeInt(Long(param2).high);
      param1.writer.writeInt(Long(param2).low);
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return Long.getLong(param1.reader.readInt(),param1.reader.readInt());
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
