package com.hurlant.crypto.tests {
  import com.hurlant.crypto.hash.SHA224;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class SHA224Test extends TestCase {
    public function SHA224Test(param1:ITestHarness) {
      super(param1,"SHA-224 Test");
      runTest(this.testSha224,"SHA-224 Test Vectors");
      param1.endTestCase();
    }

    public function testSha224() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local1:Array = [Hex.fromString("abc"),Hex.fromString("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")];
      var local2:Array = ["23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7","75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525"];
      var local3:SHA224 = new SHA224();
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = local3.hash(local5);
        assert("SHA224 Test " + local4,Hex.fromArray(local6) == local2[local4]);
        local4++;
      }
    }

    public function testLongSha224() : void {
      var local1:ByteArray = new ByteArray();
      var local2:uint = uint("a".charCodeAt(0));
      var local3:uint = 0;
      while(local3 < 1000000) {
        local1[local3] = local2;
        local3++;
      }
      var local4:SHA224 = new SHA224();
      var local5:ByteArray = local4.hash(local1);
      var local6:String = "20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67";
      assert("SHA224 Long Test",Hex.fromArray(local5) == local6);
    }
  }
}
