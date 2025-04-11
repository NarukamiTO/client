package alternativa.protocol {
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;

  public interface IProtocol {
    function registerCodec(param1:ICodecInfo, param2:ICodec) : void;
    function registerCodecForType(param1:Class, param2:ICodec) : void;
    function getCodec(param1:ICodecInfo) : ICodec;
    function makeCodecInfo(param1:Class) : ICodecInfo;
    function wrapPacket(param1:IDataOutput, param2:ProtocolBuffer, param3:CompressionType) : void;
    function unwrapPacket(param1:IDataInput, param2:ProtocolBuffer, param3:CompressionType) : Boolean;
    function decode(param1:Class, param2:ByteArray) : *;
  }
}
