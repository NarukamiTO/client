package com.hurlant.crypto.tests {
  import com.hurlant.crypto.prng.TLSPRF;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class TLSPRFTest extends TestCase {
    public function TLSPRFTest(param1:ITestHarness) {
      super(param1,"TLS-PRF Testing");
      runTest(this.testVector,"TLF-PRF Test Vector");
      param1.endTestCase();
    }

    private function testVector() : void {
      var local1:ByteArray = new ByteArray();
      var local2:uint = 0;
      while(local2 < 48) {
        local1[local2] = 171;
        local2++;
      }
      var local3:String = "PRF Testvector";
      var local4:ByteArray = new ByteArray();
      local2 = 0;
      while(local2 < 64) {
        local4[local2] = 205;
        local2++;
      }
      var local5:TLSPRF = new TLSPRF(local1,local3,local4);
      var local6:ByteArray = new ByteArray();
      local5.nextBytes(local6,104);
      var local7:String = "D3 D4 D1 E3 49 B5 D5 15 04 46 66 D5 1D E3 2B AB" + "25 8C B5 21 B6 B0 53 46 3E 35 48 32 FD 97 67 54" + "44 3B CF 9A 29 65 19 BC 28 9A BC BC 11 87 E4 EB" + "D3 1E 60 23 53 77 6C 40 8A AF B7 4C BC 85 EF F6" + "92 55 F9 78 8F AA 18 4C BB 95 7A 98 19 D8 4A 5D" + "7E B0 06 EB 45 9D 3A E8 DE 98 10 45 4B 8B 2D 8F" + "1A FB C6 55 A8 C9 A0 13";
      var local8:String = Hex.fromArray(Hex.toArray(local7));
      assert("out == expected",Hex.fromArray(local6) == local8);
    }
  }
}
