package com.hurlant.crypto.tls {
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.crypto.hash.SHA1;
  import com.hurlant.util.Hex;
  import flash.utils.ByteArray;

  public class SSLSecurityParameters implements ISecurityParameters {
    public static const COMPRESSION_NULL:uint = 0;
    public static const PROTOCOL_VERSION:uint = 768;

    private var entity:uint;
    private var bulkCipher:uint;
    private var cipherType:uint;
    private var keySize:uint;
    private var keyMaterialLength:uint;
    private var keyBlock:ByteArray;
    private var IVSize:uint;
    private var MAC_length:uint;
    private var macAlgorithm:uint;
    private var hashSize:uint;
    private var compression:uint;
    private var masterSecret:ByteArray;
    private var clientRandom:ByteArray;
    private var serverRandom:ByteArray;
    private var pad_1:ByteArray;
    private var pad_2:ByteArray;
    private var ignoreCNMismatch:Boolean = true;
    private var trustAllCerts:Boolean = false;
    private var trustSelfSigned:Boolean = false;

    public var keyExchange:uint;

    public function SSLSecurityParameters(param1:uint, param2:ByteArray = null, param3:ByteArray = null) {
      super();
      this.entity = param1;
      this.reset();
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
      this.pad_1 = new ByteArray();
      this.pad_2 = new ByteArray();
      var local2:int = 0;
      while(local2 < 48) {
        this.pad_1.writeByte(54);
        this.pad_2.writeByte(92);
        local2++;
      }
    }

    public function setCompression(param1:uint) : void {
      this.compression = param1;
    }

    public function setPreMasterSecret(param1:ByteArray) : void {
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local6:int = 0;
      var local7:int = 0;
      var local2:ByteArray = new ByteArray();
      var local3:ByteArray = new ByteArray();
      var local8:SHA1 = new SHA1();
      var local9:MD5 = new MD5();
      var local10:ByteArray = new ByteArray();
      local10.writeBytes(param1);
      local10.writeBytes(this.clientRandom);
      local10.writeBytes(this.serverRandom);
      this.masterSecret = new ByteArray();
      var local11:uint = 65;
      local6 = 0;
      while(local6 < 3) {
        local2.position = 0;
        local7 = 0;
        while(local7 < local6 + 1) {
          local2.writeByte(local11);
          local7++;
        }
        local11++;
        local2.writeBytes(local10);
        local4 = local8.hash(local2);
        local3.position = 0;
        local3.writeBytes(param1);
        local3.writeBytes(local4);
        local5 = local9.hash(local3);
        this.masterSecret.writeBytes(local5);
        local6++;
      }
      local10.position = 0;
      local10.writeBytes(this.masterSecret);
      local10.writeBytes(this.serverRandom);
      local10.writeBytes(this.clientRandom);
      this.keyBlock = new ByteArray();
      local2 = new ByteArray();
      local3 = new ByteArray();
      local11 = 65;
      local6 = 0;
      while(local6 < 16) {
        local2.position = 0;
        local7 = 0;
        while(local7 < local6 + 1) {
          local2.writeByte(local11);
          local7++;
        }
        local11++;
        local2.writeBytes(local10);
        local4 = local8.hash(local2);
        local3.position = 0;
        local3.writeBytes(this.masterSecret);
        local3.writeBytes(local4,0);
        local5 = local9.hash(local3);
        this.keyBlock.writeBytes(local5);
        local6++;
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
      var local7:ByteArray = null;
      var local9:ByteArray = null;
      var local10:ByteArray = null;
      var local3:SHA1 = new SHA1();
      var local4:MD5 = new MD5();
      var local5:ByteArray = new ByteArray();
      var local6:ByteArray = new ByteArray();
      var local8:ByteArray = new ByteArray();
      var local11:ByteArray = new ByteArray();
      if(param1 == TLSEngine.CLIENT) {
        local11.writeUnsignedInt(1129074260);
      } else {
        local11.writeUnsignedInt(1397904978);
      }
      this.masterSecret.position = 0;
      local5.writeBytes(param2);
      local5.writeBytes(local11);
      local5.writeBytes(this.masterSecret);
      local5.writeBytes(this.pad_1,0,40);
      local7 = local3.hash(local5);
      local6.writeBytes(this.masterSecret);
      local6.writeBytes(this.pad_2,0,40);
      local6.writeBytes(local7);
      local9 = local3.hash(local6);
      local5 = new ByteArray();
      local5.writeBytes(param2);
      local5.writeBytes(local11);
      local5.writeBytes(this.masterSecret);
      local5.writeBytes(this.pad_1);
      local7 = local4.hash(local5);
      local6 = new ByteArray();
      local6.writeBytes(this.masterSecret);
      local6.writeBytes(this.pad_2);
      local6.writeBytes(local7);
      local10 = local4.hash(local6);
      local8.writeBytes(local10,0,local10.length);
      local8.writeBytes(local9,0,local9.length);
      var local12:String = Hex.fromArray(local8);
      local8.position = 0;
      return local8;
    }

    public function computeCertificateVerify(param1:uint, param2:ByteArray) : ByteArray {
      return null;
    }

    public function getConnectionStates() : Object {
      var local1:int = 0;
      var local2:int = 0;
      var local3:int = 0;
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local6:ByteArray = null;
      var local7:ByteArray = null;
      var local8:ByteArray = null;
      var local9:ByteArray = null;
      var local10:SSLConnectionState = null;
      var local11:SSLConnectionState = null;
      if(this.masterSecret != null) {
        local1 = this.hashSize as Number;
        local2 = this.keySize as Number;
        local3 = this.IVSize as Number;
        local4 = new ByteArray();
        local5 = new ByteArray();
        local6 = new ByteArray();
        local7 = new ByteArray();
        local8 = new ByteArray();
        local9 = new ByteArray();
        this.keyBlock.position = 0;
        this.keyBlock.readBytes(local4,0,local1);
        this.keyBlock.readBytes(local5,0,local1);
        this.keyBlock.readBytes(local6,0,local2);
        this.keyBlock.readBytes(local7,0,local2);
        this.keyBlock.readBytes(local8,0,local3);
        this.keyBlock.readBytes(local9,0,local3);
        this.keyBlock.position = 0;
        local10 = new SSLConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,local4,local6,local8);
        local11 = new SSLConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,local5,local7,local9);
        if(this.entity == TLSEngine.CLIENT) {
          return {
            "read":local11,
            "write":local10
          };
        }
        return {
          "read":local10,
          "write":local11
        };
      }
      return {
        "read":new SSLConnectionState(),
        "write":new SSLConnectionState()
      };
    }
  }
}
