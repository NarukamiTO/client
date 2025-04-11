package platform.client.fp10.core.network.command.control.server {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import flash.utils.ByteArray;

  public class HashResponseCommandCodec implements ICodec {
    private static const HASH_BYTE_LENGTH:int = 32;

    private var byteCodec:ICodec;
    private var booleanCodec:ICodec;

    public function HashResponseCommandCodec(param1:IProtocol) {
      super();
      this.init(param1);
    }

    public function init(param1:IProtocol) : void {
      this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.booleanCodec = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ByteArray = new ByteArray();
      var local3:int = 0;
      while(local3 < HASH_BYTE_LENGTH) {
        local2.writeByte(int(this.byteCodec.decode(param1)));
        local3++;
      }
      local2.position = 0;
      var local4:Boolean = Boolean(this.booleanCodec.decode(param1));
      return new HashResponseCommand(local2,local4);
    }
  }
}
