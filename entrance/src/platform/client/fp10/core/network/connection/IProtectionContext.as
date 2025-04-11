package platform.client.fp10.core.network.connection {
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;

  public interface IProtectionContext {
    function wrap(param1:IDataOutput, param2:ByteArray) : void;
    function unwrap(param1:ByteArray, param2:IDataInput) : void;
    function reset() : void;
  }
}
