package com.hurlant.crypto.tls {
  import alternativa.osgi.service.clientlog.IClientLog;
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.crypto.hash.SHA1;
  import com.hurlant.crypto.prng.TLSPRF;
  import com.hurlant.crypto.rsa.RSAKey;
  import flash.utils.ByteArray;

  public class TLSSecurityParameters implements ISecurityParameters {
    [Inject]
    public static var clientLog:IClientLog;
    public static var USER_CERTIFICATE:String;

    public static const LOG_CHANNEL:String = "tlsengine";
    public static const COMPRESSION_NULL:uint = 0;

    public static var IGNORE_CN_MISMATCH:Boolean = true;
    public static var ENABLE_USER_CLIENT_CERTIFICATE:Boolean = false;

    public static const PROTOCOL_VERSION:uint = 769;

    private var cert:ByteArray;
    private var key:RSAKey;
    private var entity:uint;
    private var bulkCipher:uint;
    private var cipherType:uint;
    private var keySize:uint;
    private var keyMaterialLength:uint;
    private var IVSize:uint;
    private var macAlgorithm:uint;
    private var hashSize:uint;
    private var compression:uint;
    private var masterSecret:ByteArray;
    private var clientRandom:ByteArray;
    private var serverRandom:ByteArray;
    private var ignoreCNMismatch:Boolean = true;
    private var trustAllCerts:Boolean = false;
    private var trustSelfSigned:Boolean = false;
    private var tlsDebug:Boolean = false;

    public var keyExchange:uint;

    public function TLSSecurityParameters(param1:uint, param2:ByteArray = null, param3:RSAKey = null) {
      super();
      this.entity = param1;
      this.reset();
      this.key = param3;
      this.cert = param2;
    }

    public function get version() : uint {
      return PROTOCOL_VERSION;
    }

    public function reset() : void {
      this.bulkCipher = BulkCiphers.NULL;
      this.cipherType = BulkCiphers.BLOCK_CIPHER;
      this.macAlgorithm = MACs.NULL;
      this.compression = COMPRESSION_NULL;
      this.masterSecret = null;
    }

    public function getBulkCipher() : uint {
      return this.bulkCipher;
    }

    public function getCipherType() : uint {
      return this.cipherType;
    }

    public function getMacAlgorithm() : uint {
      return this.macAlgorithm;
    }

    public function setCipher(param1:uint) : void {
      this.bulkCipher = CipherSuites.getBulkCipher(param1);
      this.cipherType = BulkCiphers.getType(this.bulkCipher);
      this.keySize = BulkCiphers.getExpandedKeyBytes(this.bulkCipher);
      this.keyMaterialLength = BulkCiphers.getKeyBytes(this.bulkCipher);
      this.IVSize = BulkCiphers.getIVSize(this.bulkCipher);
      this.keyExchange = CipherSuites.getKeyExchange(param1);
      this.macAlgorithm = CipherSuites.getMac(param1);
      this.hashSize = MACs.getHashSize(this.macAlgorithm);
    }

    public function setCompression(param1:uint) : void {
      this.compression = param1;
    }

    public function setPreMasterSecret(param1:ByteArray) : void {
      var local2:ByteArray = new ByteArray();
      local2.writeBytes(this.clientRandom,0,this.clientRandom.length);
      local2.writeBytes(this.serverRandom,0,this.serverRandom.length);
      var local3:TLSPRF = new TLSPRF(param1,"master secret",local2);
      this.masterSecret = new ByteArray();
      local3.nextBytes(this.masterSecret,48);
      if(this.tlsDebug) {
      }
    }

    public function setClientRandom(param1:ByteArray) : void {
      this.clientRandom = param1;
    }

    public function setServerRandom(param1:ByteArray) : void {
      this.serverRandom = param1;
    }

    public function get useRSA() : Boolean {
      return KeyExchanges.useRSA(this.keyExchange);
    }

    public function computeVerifyData(param1:uint, param2:ByteArray) : ByteArray {
      var local3:ByteArray = new ByteArray();
      var local4:MD5 = new MD5();
      if(this.tlsDebug) {
      }
      local3.writeBytes(local4.hash(param2),0,local4.getHashSize());
      var local5:SHA1 = new SHA1();
      local3.writeBytes(local5.hash(param2),0,local5.getHashSize());
      if(this.tlsDebug) {
      }
      var local6:TLSPRF = new TLSPRF(this.masterSecret,param1 == TLSEngine.CLIENT ? "client finished" : "server finished",local3);
      var local7:ByteArray = new ByteArray();
      local6.nextBytes(local7,12);
      if(this.tlsDebug) {
        local7.position = 0;
      }
      return local7;
    }

    public function computeCertificateVerify(param1:uint, param2:ByteArray) : ByteArray {
      var local3:ByteArray = new ByteArray();
      var local4:MD5 = new MD5();
      local3.writeBytes(local4.hash(param2),0,local4.getHashSize());
      var local5:SHA1 = new SHA1();
      local3.writeBytes(local5.hash(param2),0,local5.getHashSize());
      local3.position = 0;
      var local6:ByteArray = new ByteArray();
      this.key.sign(local3,local6,local3.bytesAvailable);
      local6.position = 0;
      return local6;
    }

    public function getConnectionStates() : Object {
      var local1:ByteArray = null;
      var local2:TLSPRF = null;
      var local3:ByteArray = null;
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:ByteArray = null;
      var local8:ByteArray = null;
      var local9:TLSConnectionState = null;
      var local10:TLSConnectionState = null;
      if(this.masterSecret != null) {
        local1 = new ByteArray();
        local1.writeBytes(this.serverRandom,0,this.serverRandom.length);
        local1.writeBytes(this.clientRandom,0,this.clientRandom.length);
        local2 = new TLSPRF(this.masterSecret,"key expansion",local1);
        local3 = new ByteArray();
        local2.nextBytes(local3,this.hashSize);
        local4 = new ByteArray();
        local2.nextBytes(local4,this.hashSize);
        local5 = new ByteArray();
        local2.nextBytes(local5,this.keyMaterialLength);
        local6 = new ByteArray();
        local2.nextBytes(local6,this.keyMaterialLength);
        local7 = new ByteArray();
        local2.nextBytes(local7,this.IVSize);
        local8 = new ByteArray();
        local2.nextBytes(local8,this.IVSize);
        local9 = new TLSConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,local3,local5,local7);
        local10 = new TLSConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,local4,local6,local8);
        if(this.entity == TLSEngine.CLIENT) {
          return {
            "read":local10,
            "write":local9
          };
        }
        return {
          "read":local9,
          "write":local10
        };
      }
      return {
        "read":new TLSConnectionState(),
        "write":new TLSConnectionState()
      };
    }
  }
}
