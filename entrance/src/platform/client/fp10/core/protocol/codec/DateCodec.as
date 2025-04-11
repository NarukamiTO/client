package platform.client.fp10.core.protocol.codec {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;

  public class DateCodec implements ICodec {
    public function DateCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      throw new Error("Not implemented");
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:uint = uint(param1.reader.readInt());
      var local3:uint = uint(param1.reader.readInt());
      return new Date(Long.getLong(local2,local3));
    }
  }
}
