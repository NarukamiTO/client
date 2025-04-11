package com.hurlant.crypto.cert {
  import com.hurlant.crypto.hash.IHash;
  import com.hurlant.crypto.hash.MD2;
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.crypto.hash.SHA1;
  import com.hurlant.crypto.rsa.RSAKey;
  import com.hurlant.util.ArrayUtil;
  import com.hurlant.util.Base64;
  import com.hurlant.util.der.ByteString;
  import com.hurlant.util.der.DER;
  import com.hurlant.util.der.OID;
  import com.hurlant.util.der.ObjectIdentifier;
  import com.hurlant.util.der.PEM;
  import com.hurlant.util.der.Sequence;
  import com.hurlant.util.der.Type;
  import com.hurlant.util.der.Type2;
  import flash.utils.ByteArray;
  import flash.utils.getTimer;

  public class X509Certificate {
    private var _loaded:Boolean;
    private var _param:*;
    private var _obj2:Object;

    public function X509Certificate(param1:*) {
      super();
      this._loaded = false;
      this._param = param1;
    }

    private function load() : void {
      var local2:ByteArray = null;
      var local3:int = 0;
      if(this._loaded) {
        return;
      }
      var local1:* = this._param;
      if(local1 is String) {
        local2 = PEM.readCertIntoArray(local1 as String);
      } else if(local1 is ByteArray) {
        local2 = local1;
      }
      if(local2 != null) {
        local3 = getTimer();
        local3 = getTimer();
        this._obj2 = Type2.Certificate.fromDER(local2,local2.length);
        this._loaded = true;
        return;
      }
      throw new Error("Invalid x509 Certificate parameter: " + local1);
    }

    public function isSigned(param1:X509CertificateCollection, param2:X509CertificateCollection, param3:Date = null) : Boolean {
      this.load();
      if(param3 == null) {
        param3 = new Date();
      }
      var local4:Date = this.getNotBefore();
      var local5:Date = this.getNotAfter();
      if(param3.getTime() < local4.getTime()) {
        return false;
      }
      if(param3.getTime() > local5.getTime()) {
        return false;
      }
      var local6:String = this.getIssuerPrincipal();
      var local7:X509Certificate = param2.getCertificate(local6);
      var local8:Boolean = false;
      if(local7 == null) {
        local7 = param1.getCertificate(local6);
        if(local7 == null) {
          return false;
        }
      } else {
        local8 = true;
      }
      if(local7 == this) {
        return false;
      }
      if(!(local8 && local7.isSelfSigned(param3)) && !local7.isSigned(param1,param2,param3)) {
        return false;
      }
      var local9:RSAKey = local7.getPublicKey();
      return this.verifyCertificate(local9);
    }

    public function isSelfSigned(param1:Date) : Boolean {
      this.load();
      var local2:RSAKey = this.getPublicKey();
      return this.verifyCertificate(local2);
    }

    private function verifyCertificate(param1:RSAKey) : Boolean {
      var local3:IHash = null;
      var local4:String = null;
      var local2:String = this.getAlgorithmIdentifier();
      switch(local2) {
        case OID.SHA1_WITH_RSA_ENCRYPTION:
          local3 = new SHA1();
          local4 = OID.SHA1_ALGORITHM;
          break;
        case OID.MD2_WITH_RSA_ENCRYPTION:
          local3 = new MD2();
          local4 = OID.MD2_ALGORITHM;
          break;
        case OID.MD5_WITH_RSA_ENCRYPTION:
          local3 = new MD5();
          local4 = OID.MD5_ALGORITHM;
          break;
        default:
          return false;
      }
      var local5:ByteArray = this._obj2.toBeSigned_bin;
      var local6:ByteArray = new ByteArray();
      param1.verify(this._obj2.signature,local6,this._obj2.signature.length);
      local6.position = 0;
      local5 = local3.hash(local5);
      var local7:Object = DER.parse(local6,Type.RSA_SIGNATURE);
      if(local7.algorithm.algorithmId.toString() != local4) {
        return false;
      }
      if(!ArrayUtil.equals(local7.hash,local5)) {
        return false;
      }
      return true;
    }

    private function signCertificate(param1:RSAKey, param2:String) : ByteArray {
      var local3:IHash = null;
      var local4:String = null;
      switch(param2) {
        case OID.SHA1_WITH_RSA_ENCRYPTION:
          local3 = new SHA1();
          local4 = OID.SHA1_ALGORITHM;
          break;
        case OID.MD2_WITH_RSA_ENCRYPTION:
          local3 = new MD2();
          local4 = OID.MD2_ALGORITHM;
          break;
        case OID.MD5_WITH_RSA_ENCRYPTION:
          local3 = new MD5();
          local4 = OID.MD5_ALGORITHM;
          break;
        default:
          return null;
      }
      var local5:ByteArray = this._obj2.toBeSigned_bin;
      local5 = local3.hash(local5);
      var local6:Sequence = new Sequence();
      local6[0] = new Sequence();
      local6[0][0] = new ObjectIdentifier(0,0,local4);
      local6[0][1] = null;
      local6[1] = new ByteString();
      local6[1].writeBytes(local5);
      local5 = local6.toDER();
      var local7:ByteArray = new ByteArray();
      param1.sign(local5,local7,local5.length);
      return local7;
    }

    public function getPublicKey() : RSAKey {
      this.load();
      var local1:ByteArray = this._obj2.toBeSigned.subjectPublicKeyInfo.subjectPublicKey as ByteArray;
      local1.position = 0;
      var local2:Object = DER.parse(local1,[{"name":"N"},{"name":"E"}]);
      return new RSAKey(local2.N,local2.E.valueOf());
    }

    public function getSubjectPrincipal() : String {
      this.load();
      return Base64.encodeByteArray(this._obj2.toBeSigned.subject_bin);
    }

    public function getIssuerPrincipal() : String {
      this.load();
      return Base64.encodeByteArray(this._obj2.toBeSigned.issuer_bin);
    }

    public function getAlgorithmIdentifier() : String {
      return this._obj2.algorithm.algorithm.toString();
    }

    public function getNotBefore() : Date {
      return this._obj2.toBeSigned.validity.notBefore.utcTime;
    }

    public function getNotAfter() : Date {
      return this._obj2.toBeSigned.validity.notAfter.utcTime;
    }

    public function getCommonName() : String {
      var local3:Object = null;
      var local4:* = undefined;
      var local5:* = undefined;
      var local6:String = null;
      var local1:Array = this._obj2.toBeSigned.subject.sequence;
      var local2:int = 0;
      while(local2 < local1.length) {
        local3 = local1[local2][0];
        if(Boolean(local3.commonName)) {
          local4 = local3.commonName.value;
          var local7:int = 0;
          var local8:* = local4;
          for(local6 in local8) {
            local5 = local4[local6];
          }
          return local5;
        }
        local2++;
      }
      return "hi";
    }
  }
}
