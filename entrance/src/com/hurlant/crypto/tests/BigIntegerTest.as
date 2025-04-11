package com.hurlant.crypto.tests {
  import com.hurlant.math.BigInteger;
  import flash.utils.ByteArray;

  public class BigIntegerTest extends TestCase {
    public function BigIntegerTest(param1:ITestHarness) {
      super(param1,"BigInteger Tests");
      runTest(this.testAdd,"BigInteger Addition");
      runTest(this.testSigned,"BigInteger Signed number conversion");
      runTest(this.testSigned2,"BigInteger to Number: signed numbers");
      param1.endTestCase();
    }

    public function testAdd() : void {
      var local1:BigInteger = BigInteger.nbv(25);
      var local2:BigInteger = BigInteger.nbv(1002);
      var local3:BigInteger = local1.add(local2);
      var local4:int = local3.valueOf();
      assert("25+1002 = " + local4,25 + 1002 == local4);
      var local5:BigInteger = new BigInteger("e564d8b801a61f47",16,true);
      var local6:BigInteger = new BigInteger("99246db2a3507fa",16,true);
      local6 = local6.add(local5);
      assert("xp==eef71f932bdb2741",local6.toString(16) == "eef71f932bdb2741");
    }

    public function testSigned() : void {
      var local1:BigInteger = new BigInteger("1");
      var local2:BigInteger = new BigInteger("2");
      var local3:BigInteger = local1.subtract(local2);
      var local4:ByteArray = local3.toByteArray();
      var local5:BigInteger = new BigInteger(local4);
      var local6:ByteArray = local5.toByteArray();
      var local7:Boolean = local3.equals(local5);
      assert("arr_i3.length==1",local4.length == 1);
      assert("arr_i4.length==1",local6.length == 1);
      assert("-1 == BigInteger(ByteArray(-1))",local3.equals(local5));
    }

    public function testSigned2() : void {
      var local1:BigInteger = BigInteger.nbv(-13);
      assert("i1==-13",local1.valueOf() == -13);
    }
  }
}
