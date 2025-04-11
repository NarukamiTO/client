package platform.client.fp10.core.network.connection.protection {
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  import platform.client.fp10.core.network.connection.IProtectionContext;

  public class PrimitiveProtectionContext implements IProtectionContext {
    public static const INSTANCE:PrimitiveProtectionContext = new PrimitiveProtectionContext();

    public function PrimitiveProtectionContext() {
      super();
    }

    public function wrap(param1:IDataOutput, param2:ByteArray) : void {
      param1.writeBytes(param2,param2.position);
    }

    public function unwrap(param1:ByteArray, param2:IDataInput) : void {
      param2.readBytes(param1,param1.position);
    }

    public function reset() : void {
    }
  }
}
