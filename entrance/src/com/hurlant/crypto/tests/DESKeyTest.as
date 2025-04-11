package com.hurlant.crypto.tests {
  import com.hurlant.crypto.symmetric.DESKey;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class DESKeyTest extends TestCase {
    public function DESKeyTest(param1:ITestHarness) {
      super(param1,"DESKey Test");
      runTest(this.testECB,"DES ECB Test Vectors");
      param1.endTestCase();
    }

    public function testECB() : void {
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:DESKey = null;
      var local8:String = null;
      var local1:Array = ["3b3898371520f75e","10316E028C8F3B4A","0101010101010101","0101010101010101","0101010101010101","0101010101010101","0101010101010101","0101010101010101","0101010101010101","0101010101010101","0101010101010101","8001010101010101","4001010101010101","2001010101010101","1001010101010101","0801010101010101","0401010101010101","0201010101010101","0180010101010101","0140010101010101"];
      var local2:Array = ["0000000000000000","0000000000000000","8000000000000000","4000000000000000","2000000000000000","1000000000000000","0800000000000000","0400000000000000","0200000000000000","0100000000000000","0080000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000","0000000000000000"];
      var local3:Array = ["83A1E814889253E0","82DCBAFBDEAB6602","95F8A5E5DD31D900","DD7F121CA5015619","2E8653104F3834EA","4BD388FF6CD81D4F","20B9E767B2FB1456","55579380D77138EF","6CC5DEFAAF04512F","0D9F279BA5D87260","D9031B0271BD5A0A","95A8D72813DAA94D","0EEC1487DD8C26D5","7AD16FFB79C45926","D3746294CA6A6CF3","809F5F873C1FD761","C02FAFFEC989D1FC","4615AA1D33E72F10","2055123350C00858","DF3B99D6577397C8"];
      var local4:uint = 0;
      while(local4 < local1.length) {
        local5 = Hex.toArray(local1[local4]);
        local6 = Hex.toArray(local2[local4]);
        local7 = new DESKey(local5);
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
