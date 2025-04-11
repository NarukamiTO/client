package com.hurlant.crypto.tests {
  import com.hurlant.crypto.symmetric.TripleDESKey;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class TripleDESKeyTest extends TestCase {
    public function TripleDESKeyTest(param1:ITestHarness) {
      super(param1,"Triped Des Test");
      runTest(this.testECB,"Triple DES ECB Test Vectors");
      param1.endTestCase();
    }

    public function testECB() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:TripleDESKey = null;
      var local8:String = null;
      var local1:Array = ["010101010101010101010101010101010101010101010101","dd24b3aafcc69278d650dad234956b01e371384619492ac4"];
      var local2:Array = ["8000000000000000","F36B21045A030303"];
      var local3:Array = ["95F8A5E5DD31D900","E823A43DEEA4D0A4"];
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = Hex.toArray(local2[local4]);
        local7 = new TripleDESKey(local5);
        local7.encrypt(local6);
        local8 = Hex.fromArray(local6).toUpperCase();
        assert("comparing " + local3[local4] + " to " + local8,local3[local4] == local8);
        local7.decrypt(local6);
        local8 = Hex.fromArray(local6).toUpperCase();
        assert("comparing " + local2[local4] + " to " + local8,local2[local4] == local8);
        local4++;
      }
    }
  }
}
