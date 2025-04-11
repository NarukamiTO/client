package com.hurlant.crypto.tests {
  import com.hurlant.crypto.hash.MD2;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class MD2Test extends TestCase {
    public function MD2Test(param1:ITestHarness) {
      super(param1,"MD2 Test");
      runTest(this.testMd2,"MD2 Test Vectors");
      param1.endTestCase();
    }

    public function testMd2() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local1:Array = ["",Hex.fromString("a"),Hex.fromString("abc"),Hex.fromString("message digest"),Hex.fromString("abcdefghijklmnopqrstuvwxyz"),Hex.fromString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),Hex.fromString("12345678901234567890123456789012345678901234567890123456789012345678901234567890")];
      var local2:Array = ["8350e5a3e24c153df2275c9f80692773","32ec01ec4a6dac72c0ab96fb34c0b5d1","da853b0d3f88d99b30283a69e6ded6bb","ab4f496bfb2a530b219ff33031fe06b0","4e8ddff3650292ab5a4108c3aa47940b","da33def2a42df13975352846c30338cd","d5976f79d83d3a0dc9806c3c66f3efd8"];
      var local3:MD2 = new MD2();
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = local3.hash(local5);
        assert("MD2 Test " + local4,Hex.fromArray(local6) == local2[local4]);
        local4++;
      }
    }
  }
}
