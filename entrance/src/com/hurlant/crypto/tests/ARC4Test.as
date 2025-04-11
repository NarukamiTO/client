package com.hurlant.crypto.tests {
  import com.hurlant.crypto.prng.ARC4;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class ARC4Test extends TestCase {
    public function ARC4Test(param1:ITestHarness) {
      super(param1,"ARC4 Test");
      runTest(this.testLameVectors,"ARC4 Test Vectors");
      param1.endTestCase();
    }

    public function testLameVectors() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:ARC4 = null;
      var local8:String = null;
      var local1:Array = [Hex.fromString("Key"),Hex.fromString("Wiki"),Hex.fromString("Secret")];
      var local2:Array = [Hex.fromString("Plaintext"),Hex.fromString("pedia"),Hex.fromString("Attack at dawn")];
      var local3:Array = ["BBF316E8D940AF0AD3","1021BF0420","45A01F645FC35B383552544B9BF5"];
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = Hex.toArray(local2[local4]);
        local7 = new ARC4(local5);
        local7.encrypt(local6);
        local8 = Hex.fromArray(local6).toUpperCase();
        assert("comparing " + local3[local4] + " to " + local8,local3[local4] == local8);
        local7.init(local5);
        local7.decrypt(local6);
        local8 = Hex.fromArray(local6);
        assert("comparing " + local2[local4] + " to " + local8,local2[local4] == local8);
        local4++;
      }
    }
  }
}
