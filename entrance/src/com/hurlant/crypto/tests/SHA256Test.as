package com.hurlant.crypto.tests {
  import com.hurlant.crypto.hash.SHA256;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class SHA256Test extends TestCase {
    public function SHA256Test(param1:ITestHarness) {
      super(param1,"SHA-256 Test");
      runTest(this.testSha256,"SHA-256 Test Vectors");
      param1.endTestCase();
    }

    public function testSha256() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local1:Array = [Hex.fromString(""),Hex.fromString("a"),Hex.fromString("abc"),Hex.fromString("message digest"),Hex.fromString("abcdefghijklmnopqrstuvwxyz"),Hex.fromString("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"),Hex.fromString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),Hex.fromString("12345678901234567890123456789012345678901234567890123456789012345678901234567890")];
      var local2:Array = ["E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855","CA978112CA1BBDCAFAC231B39A23DC4DA786EFF8147C4E72B9807785AFEE48BB","BA7816BF8F01CFEA414140DE5DAE2223B00361A396177A9CB410FF61F20015AD","F7846F55CF23E14EEBEAB5B4E1550CAD5B509E3348FBC4EFA3A1413D393CB650","71C480DF93D6AE2F1EFAD1447C66C9525E316218CF51FC8D9ED832F2DAF18B73","248D6A61D20638B8E5C026930C3E6039A33CE45964FF2167F6ECEDD419DB06C1","DB4BFCBD4DA0CD85A60C3C37D3FBD8805C77F15FC6B1FDFE614EE0A7C8FDB4C0","F371BC4A311F2B009EEF952DD83CA80E2B60026C8E935592D0F9C308453C813E"];
      var local3:SHA256 = new SHA256();
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = local3.hash(local5);
        assert("SHA256 Test " + local4,Hex.fromArray(local6) == local2[local4].toLowerCase());
        local4++;
      }
    }
  }
}
