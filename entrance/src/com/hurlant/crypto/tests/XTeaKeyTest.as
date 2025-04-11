package com.hurlant.crypto.tests {
  import com.hurlant.crypto.symmetric.XTeaKey;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class XTeaKeyTest extends TestCase {
    public function XTeaKeyTest(param1:ITestHarness) {
      super(param1,"XTeaKey Test");
      runTest(this.testGetBlockSize,"XTea Block Size");
      runTest(this.testVectors,"XTea Test Vectors");
      param1.endTestCase();
    }

    public function testGetBlockSize() : void {
      var local1:XTeaKey = new XTeaKey(Hex.toArray("deadbabecafebeefdeadbabecafebeef"));
      assert("tea blocksize",local1.getBlockSize() == 8);
    }

    public function testVectors() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:XTeaKey = null;
      var local8:String = null;
      var local1:Array = ["00000000000000000000000000000000","2b02056806144976775d0e266c287843"];
      var local2:Array = ["0000000000000000","74657374206d652e"];
      var local3:Array = ["2dc7e8d3695b0538","7909582138198783"];
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = Hex.toArray(local2[local4]);
        local7 = new XTeaKey(local5);
        local7.encrypt(local6);
        local8 = Hex.fromArray(local6);
        assert("comparing " + local3[local4] + " to " + local8,local3[local4] == local8);
        local6.position = 0;
        local7.decrypt(local6);
        local8 = Hex.fromArray(local6);
        assert("comparing " + local2[local4] + " to " + local8,local2[local4] == local8);
        local4++;
      }
    }
  }
}
