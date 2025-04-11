package com.hurlant.crypto.tests {
  import com.hurlant.crypto.rsa.RSAKey;
  import com.hurlant.util.Hex;
  import com.hurlant.util.der.PEM;
  import flash.utils.ByteArray;

  public class RSAKeyTest extends TestCase {
    public function RSAKeyTest(param1:ITestHarness) {
      super(param1,"RSA Testing");
      runTest(this.testSmoke,"RSA smoke test");
      runTest(this.testGenerate,"RSA Key Generation test");
      runTest(this.testPEM,"RSA Private Key PEM parsing");
      runTest(this.testPEM2,"RSA Public Key PEM parsing");
      runTest(this.testAdobeSample,"RSA sample code from Adobe article");
      runTest(this.testLongText,"RSA long text encryption/decryption");
      param1.endTestCase();
    }

    public function testSmoke() : void {
      var local1:String = "C4E3F7212602E1E396C0B6623CF11D26204ACE3E7D26685E037AD2507DCE82FC" + "28F2D5F8A67FC3AFAB89A6D818D1F4C28CFA548418BD9F8E7426789A67E73E41";
      var local2:String = "10001";
      var local3:String = "7cd1745aec69096129b1f42da52ac9eae0afebbe0bc2ec89253598dcf454960e" + "3e5e4ec9f8c87202b986601dd167253ee3fb3fa047e14f1dfd5ccd37e931b29d";
      var local4:String = "f0e4dd1eac5622bd3932860fc749bbc48662edabdf3d2826059acc0251ac0d3b";
      var local5:String = "d13cb38fbcd06ee9bca330b4000b3dae5dae12b27e5173e4d888c325cda61ab3";
      var local6:String = "b3d5571197fc31b0eb6b4153b425e24c033b054d22b9c8282254fe69d8c8c593";
      var local7:String = "968ffe89e50d7b72585a79b65cfdb9c1da0963cceb56c3759e57334de5a0ac3f";
      var local8:String = "d9bc4f420e93adad9f007d0e5744c2fe051c9ed9d3c9b65f439a18e13d6e3908";
      var local9:RSAKey = RSAKey.parsePrivateKey(local1,local2,local3,local4,local5,local6,local7,local8);
      var local10:String = "hello";
      var local11:ByteArray = Hex.toArray(Hex.fromString(local10));
      var local12:ByteArray = new ByteArray();
      var local13:ByteArray = new ByteArray();
      local9.encrypt(local11,local12,local11.length);
      local9.decrypt(local12,local13,local12.length);
      var local14:String = Hex.toString(Hex.fromArray(local13));
      assert("rsa encrypt+decrypt",local10 == local14);
    }

    public function testGenerate() : void {
      var local1:RSAKey = RSAKey.generate(256,"10001");
      var local2:String = "hello";
      var local3:ByteArray = Hex.toArray(Hex.fromString(local2));
      var local4:ByteArray = new ByteArray();
      var local5:ByteArray = new ByteArray();
      local1.encrypt(local3,local4,local3.length);
      local1.decrypt(local4,local5,local4.length);
      var local6:String = Hex.toString(Hex.fromArray(local5));
      assert("rsa encrypt+decrypt",local2 == local6);
    }

    public function testPEM() : void {
      var local1:String = "-----BEGIN RSA PRIVATE KEY-----\n" + "MGQCAQACEQDJG3bkuB9Ie7jOldQTVdzPAgMBAAECEQCOGqcPhP8t8mX8cb4cQEaR\n" + "AgkA5WTYuAGmH0cCCQDgbrto0i7qOQIINYr5btGrtccCCQCYy4qX4JDEMQIJAJll\n" + "OnLVtCWk\n" + "-----END RSA PRIVATE KEY-----";
      var local2:RSAKey = PEM.readRSAPrivateKey(local1);
      var local3:String = "hello";
      var local4:ByteArray = Hex.toArray(Hex.fromString(local3));
      var local5:ByteArray = new ByteArray();
      var local6:ByteArray = new ByteArray();
      local2.encrypt(local4,local5,local4.length);
      local2.decrypt(local5,local6,local5.length);
      var local7:String = Hex.toString(Hex.fromArray(local6));
      assert("rsa encrypt+decrypt",local3 == local7);
    }

    public function testPEM2() : void {
      var local1:String = "-----BEGIN PUBLIC KEY-----\n" + "MCwwDQYJKoZIhvcNAQEBBQADGwAwGAIRAMkbduS4H0h7uM6V1BNV3M8CAwEAAQ==\n" + "-----END PUBLIC KEY-----";
      var local2:RSAKey = PEM.readRSAPublicKey(local1);
      assert("rsa!=null",local2 != null);
    }

    public function testAdobeSample() : void {
      var local1:String = "-----BEGIN PUBLIC KEY-----" + "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBALHpyYTN96rMbkQB" + "gIoB9vH2AN47NN1YXoKxAaqpEkafQdPUw41p4gTrA0r04acE" + "m3GaWUA4YROCSKgJnvii0UsCAwEAAQ==" + "-----END PUBLIC KEY-----";
      var local2:ByteArray = Hex.toArray(Hex.fromString("MyInputString"));
      var local3:ByteArray = new ByteArray();
      var local4:RSAKey = PEM.readRSAPublicKey(local1);
      local4.encrypt(local2,local3,local2.length);
      var local5:String = Hex.fromArray(local3);
      assert("encrypted some stuff",local5.length > 5);
    }

    public function testLongText() : void {
      var local1:String = "-----BEGIN RSA PRIVATE KEY-----\n" + "MGQCAQACEQDJG3bkuB9Ie7jOldQTVdzPAgMBAAECEQCOGqcPhP8t8mX8cb4cQEaR\n" + "AgkA5WTYuAGmH0cCCQDgbrto0i7qOQIINYr5btGrtccCCQCYy4qX4JDEMQIJAJll\n" + "OnLVtCWk\n" + "-----END RSA PRIVATE KEY-----";
      var local2:RSAKey = PEM.readRSAPrivateKey(local1);
      var local3:String = "With each new release" + "of Flash Player, Adobe strives to introduce a stronger platform with" + "more robust security controls and tools for creating secure" + "applications. By leveraging those tools, compiling for recent" + "versions, performing data validation, and leveraging available SDKs," + "developers can produce more secure applications that run in Flash" + "Player.";
      var local4:ByteArray = Hex.toArray(Hex.fromString(local3));
      var local5:ByteArray = new ByteArray();
      var local6:ByteArray = new ByteArray();
      local2.encrypt(local4,local5,local4.length);
      local2.decrypt(local5,local6,local5.length);
      var local7:String = Hex.toString(Hex.fromArray(local6));
      assert("rsa long text encrypt+decrypt",local3 == local7);
    }
  }
}
