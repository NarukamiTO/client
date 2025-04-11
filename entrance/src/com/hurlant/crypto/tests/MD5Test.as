package com.hurlant.crypto.tests {
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class MD5Test extends TestCase {
    public function MD5Test(param1:ITestHarness) {
      super(param1,"MD5 Test");
      runTest(this.testMd5,"MD5 Test Vectors");
      param1.endTestCase();
    }

    public function testMd5() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local1:Array = ["",Hex.fromString("a"),Hex.fromString("abc"),Hex.fromString("message digest"),Hex.fromString("abcdefghijklmnopqrstuvwxyz"),Hex.fromString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),Hex.fromString("12345678901234567890123456789012345678901234567890123456789012345678901234567890")];
      var local2:Array = ["d41d8cd98f00b204e9800998ecf8427e","0cc175b9c0f1b6a831c399e269772661","900150983cd24fb0d6963f7d28e17f72","f96b697d7cb7938d525a2f31aaf161d0","c3fcd3d76192e4007dfb496cca67e13b","d174ab98d277d9f5a5611c2c9f419d9f","57edf4a22be3c955ac49da2e2107b67a"];
      var local3:MD5 = new MD5();
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = local3.hash(local5);
        assert("MD5 Test " + local4,Hex.fromArray(local6) == local2[local4]);
        local4++;
      }
    }
  }
}
