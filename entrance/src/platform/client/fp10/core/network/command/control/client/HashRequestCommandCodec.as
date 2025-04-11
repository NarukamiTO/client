package platform.client.fp10.core.network.command.control.client {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;

  public class HashRequestCommandCodec implements ICodec {
    private var arrayCodec:ICodec;

    public function HashRequestCommandCodec(param1:IProtocol) {
      super();
      this.init(param1);
    }

    public function init(param1:IProtocol) : void {
      this.arrayCodec = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:HashRequestCommand = HashRequestCommand(param2);
      this.arrayCodec.encode(param1,local3.parameterNames);
      this.arrayCodec.encode(param1,local3.parameterValues);
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return null;
    }
  }
}
