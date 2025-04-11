package alternativa.protocol.codec.complex {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import flash.utils.ByteArray;

  public class SimpleStringCodec implements ICodec {
    private var byteCodec:ICodec;
    private var buffer:ByteArray = new ByteArray();

    public function SimpleStringCodec(param1:IProtocol) {
      super();
      this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = int(this.byteCodec.decode(param1));
      this.buffer.clear();
      param1.reader.readBytes(this.buffer,0,local2);
      return this.buffer.toString();
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
