package alternativa.protocol {
  public interface ICodec {
    function init(param1:IProtocol) : void;
    function encode(param1:ProtocolBuffer, param2:Object) : void;
    function decode(param1:ProtocolBuffer) : Object;
  }
}
