package platform.client.fp10.core.network.connection.protection {
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  import platform.client.fp10.core.network.connection.*;

  public class XorBasedProtectionContext implements IProtectionContext {
    private var serverSequence:Vector.<int> = new Vector.<int>(8,true);
    private var serverSelector:int = 0;
    private var clientSequence:Vector.<int> = new Vector.<int>(8,true);
    private var clientSelector:int = 0;
    private var initialSeed:int;

    public function XorBasedProtectionContext(param1:ByteArray, param2:Long) {
      super();
      this.initialSeed = 0;
      var local3:int = 0;
      while(local3 < 32) {
        this.initialSeed ^= param1[local3];
        local3++;
      }
      this.initialSeed ^= param2.high >> 24 & 0xFF;
      this.initialSeed ^= param2.high >> 16 & 0xFF;
      this.initialSeed ^= param2.high >> 8 & 0xFF;
      this.initialSeed ^= param2.high >> 0 & 0xFF;
      this.initialSeed ^= param2.low >> 24 & 0xFF;
      this.initialSeed ^= param2.low >> 16 & 0xFF;
      this.initialSeed ^= param2.low >> 8 & 0xFF;
      this.initialSeed ^= param2.low >> 0 & 0xFF;
      this.initialSeed = this.initialSeed >= 128 ? this.initialSeed - 256 : this.initialSeed;
      this.reset();
    }

    public function reset() : void {
      var local1:int = 0;
      while(local1 < 8) {
        this.serverSequence[local1] = this.initialSeed ^ local1 << 3;
        this.clientSequence[local1] = this.initialSeed ^ local1 << 3 ^ 0x57;
        local1++;
      }
      this.serverSelector = 0;
      this.clientSelector = 0;
    }

    public function wrap(param1:IDataOutput, param2:ByteArray) : void {
      var local3:int = 0;
      while(param2.bytesAvailable > 0) {
        local3 = param2.readByte();
        param1.writeByte(local3 ^ this.clientSequence[this.clientSelector]);
        this.clientSequence[this.clientSelector] = local3;
        this.clientSelector ^= local3 & 7;
      }
    }

    public function unwrap(param1:ByteArray, param2:IDataInput) : void {
      while(param2.bytesAvailable > 0) {
        this.serverSequence[this.serverSelector] = param2.readByte() ^ this.serverSequence[this.serverSelector];
        param1.writeByte(this.serverSequence[this.serverSelector]);
        this.serverSelector ^= this.serverSequence[this.serverSelector] & 7;
      }
    }
  }
}
