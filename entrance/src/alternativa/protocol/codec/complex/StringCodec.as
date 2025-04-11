package alternativa.protocol.codec.complex {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.impl.LengthCodecHelper;
  import flash.utils.ByteArray;

  public class StringCodec implements ICodec {
    public function StringCodec() {
      super();
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:ByteArray = new ByteArray();
      local3.writeUTFBytes(String(param2));
      var local4:int = int(local3.length);
      LengthCodecHelper.encodeLength(param1,local4);
      param1.writer.writeBytes(local3,0,local4);
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = LengthCodecHelper.decodeLength(param1);
      return param1.reader.readUTFBytes(local2);
    }

    public function init(param1:IProtocol) : void {
    }
  }
}
