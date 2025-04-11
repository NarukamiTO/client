package alternativa.protocol.codec.complex {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.impl.LengthCodecHelper;
  import flash.utils.ByteArray;

  public class ByteArrayCodec implements ICodec {
    public function ByteArrayCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:ByteArray = ByteArray(param2);
      LengthCodecHelper.encodeLength(param1,local3.length);
      param1.writer.writeBytes(local3);
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = LengthCodecHelper.decodeLength(param1);
      var local3:ByteArray = new ByteArray();
      if(local2 > 0) {
        param1.reader.readBytes(local3,0,local2);
      }
      return local3;
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
