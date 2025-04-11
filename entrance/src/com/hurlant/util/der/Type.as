package com.hurlant.util.der {
  import com.hurlant.util.Hex;
  import com.hurlant.util.asn1.type.ASN1Type;

  public class Type {
    public static const TLS_CERT:Array = [{
      "name":"signedCertificate",
      "extract":true,
      "value":[{
        "name":"versionHolder",
        "optional":true,
        "value":[{"name":"version"}],
        "defaultValue":(function():Sequence {
          var local1:* = new Sequence(0,0);
          var local2:* = new Integer(2,1,Hex.toArray("00"));
          local1.push(local2);
          local1.version = local2;
          return local1;
        })()
      },{"name":"serialNumber"},{
        "name":"signature",
        "value":[{"name":"algorithmId"}]
      },{
        "name":"issuer",
        "extract":true,
        "value":[{"name":"type"},{"name":"value"}]
      },{
        "name":"validity",
        "value":[{"name":"notBefore"},{"name":"notAfter"}]
      },{
        "name":"subject",
        "extract":true,
        "value":[]
      },{
        "name":"subjectPublicKeyInfo",
        "value":[{
          "name":"algorithm",
          "value":[{"name":"algorithmId"}]
        },{"name":"subjectPublicKey"}]
      },{
        "name":"extensions",
        "value":[]
      }]
    },{
      "name":"algorithmIdentifier",
      "value":[{"name":"algorithmId"}]
    },{
      "name":"encrypted",
      "value":null
    }];

    public static const CERTIFICATE:Array = [{
      "name":"tbsCertificate",
      "value":[{
        "name":"tag0",
        "value":[{"name":"version"}]
      },{"name":"serialNumber"},{"name":"signature"},{
        "name":"issuer",
        "value":[{"name":"type"},{"name":"value"}]
      },{
        "name":"validity",
        "value":[{"name":"notBefore"},{"name":"notAfter"}]
      },{"name":"subject"},{
        "name":"subjectPublicKeyInfo",
        "value":[{"name":"algorithm"},{"name":"subjectPublicKey"}]
      },{"name":"issuerUniqueID"},{"name":"subjectUniqueID"},{"name":"extensions"}]
    },{"name":"signatureAlgorithm"},{"name":"signatureValue"}];

    public static const RSA_PUBLIC_KEY:Array = [{"name":"modulus"},{"name":"publicExponent"}];

    public static const RSA_SIGNATURE:Array = [{
      "name":"algorithm",
      "value":[{"name":"algorithmId"}]
    },{"name":"hash"}];

    private var test:ASN1Type = Type2.Certificate;

    public function Type() {
      super();
    }
  }
}
