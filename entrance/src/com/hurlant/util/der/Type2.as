package com.hurlant.util.der {
  import com.hurlant.util.asn1.parser.bitString;
  import com.hurlant.util.asn1.parser.bmpString;
  import com.hurlant.util.asn1.parser.boolean;
  import com.hurlant.util.asn1.parser.choice;
  import com.hurlant.util.asn1.parser.defaultValue;
  import com.hurlant.util.asn1.parser.explicitTag;
  import com.hurlant.util.asn1.parser.extract;
  import com.hurlant.util.asn1.parser.generalizedTime;
  import com.hurlant.util.asn1.parser.ia5String;
  import com.hurlant.util.asn1.parser.implicitTag;
  import com.hurlant.util.asn1.parser.integer;
  import com.hurlant.util.asn1.parser.nulll;
  import com.hurlant.util.asn1.parser.octetString;
  import com.hurlant.util.asn1.parser.oid;
  import com.hurlant.util.asn1.parser.optional;
  import com.hurlant.util.asn1.parser.printableString;
  import com.hurlant.util.asn1.parser.sequence;
  import com.hurlant.util.asn1.parser.sequenceOf;
  import com.hurlant.util.asn1.parser.setOf;
  import com.hurlant.util.asn1.parser.teletexString;
  import com.hurlant.util.asn1.parser.universalString;
  import com.hurlant.util.asn1.parser.utcTime;
  import com.hurlant.util.asn1.parser.utf8String;
  import com.hurlant.util.asn1.type.ASN1Type;
  import com.hurlant.util.asn1.type.OIDType;

  public class Type2 {
    public static const ub_name:int = 32768;
    public static const ub_common_name:int = 64;
    public static const ub_locality_name:int = 128;
    public static const ub_state_name:int = 128;
    public static const ub_organization_name:int = 64;
    public static const ub_organizational_unit_name:int = 64;
    public static const ub_title:int = 64;
    public static const ub_match:int = 128;
    public static const ub_emailaddress_length:int = 128;
    public static const ub_common_name_length:int = 64;
    public static const ub_country_name_alpha_length:int = 2;
    public static const ub_country_name_numeric_length:int = 3;
    public static const ub_domain_defined_attributes:int = 4;
    public static const ub_domain_defined_attribute_type_length:int = 8;
    public static const ub_domain_defined_attribute_value_length:int = 128;
    public static const ub_domain_name_length:int = 16;
    public static const ub_extension_attributes:int = 256;
    public static const ub_e163_4_number_length:int = 15;
    public static const ub_e163_4_sub_address_length:int = 40;
    public static const ub_generation_qualifier_length:int = 3;
    public static const ub_given_name_length:int = 16;
    public static const ub_initials_length:int = 5;
    public static const ub_integer_options:int = 256;
    public static const ub_numeric_user_id_length:int = 32;
    public static const ub_organization_name_length:int = 64;
    public static const ub_organizational_unit_name_length:int = 32;
    public static const ub_organizational_units:int = 4;
    public static const ub_pds_name_length:int = 16;
    public static const ub_pds_parameter_length:int = 30;
    public static const ub_pds_physical_address_lines:int = 6;
    public static const ub_postal_code_length:int = 16;
    public static const ub_surname_length:int = 40;
    public static const ub_terminal_id_length:int = 24;
    public static const ub_unformatted_address_length:int = 180;
    public static const ub_x121_address_length:int = 16;
    public static const ub_pkcs9_string:int = 255;
    public static const MAX:int = int.MAX_VALUE;
    public static const iso:String = "1";
    public static const identified_organization:String = "3";
    public static const dod:String = "6";
    public static const internet:String = "1";
    public static const security:String = "5";
    public static const mechanisms:String = "5";
    public static const pkix:String = "7";
    public static const id_pkix:OIDType = oid(iso,identified_organization,dod,internet,security,mechanisms,pkix);
    public static const id_pe:OIDType = oid(id_pkix,1);
    public static const id_qt:OIDType = oid(id_pkix,2);
    public static const id_kp:OIDType = oid(id_pkix,3);
    public static const id_ad:OIDType = oid(id_pkix,48);
    public static const id_qt_cps:OIDType = oid(id_qt,1);
    public static const id_qt_unotice:OIDType = oid(id_qt,2);
    public static const pkcs_9:OIDType = oid(iso,member_body,us,rsadsi,pkcs,9);
    public static const emailAddress:OIDType = oid(pkcs_9,1);
    public static const pkcs9_unstructuredName:OIDType = oid(pkcs_9,2);
    public static const joint_iso_ccitt:String = "2";
    public static const ds:String = "5";
    public static const id_at:OIDType = oid(joint_iso_ccitt,ds,4);
    public static const id_at_commonName:OIDType = oid(id_at,3);
    public static const id_at_surname:OIDType = oid(id_at,4);
    public static const id_at_countryName:OIDType = oid(id_at,6);
    public static const id_at_localityName:OIDType = oid(id_at,7);
    public static const id_at_stateOrProvinceName:OIDType = oid(id_at,8);
    public static const id_at_organizationName:OIDType = oid(id_at,10);
    public static const id_at_organizationalUnitName:OIDType = oid(id_at,11);
    public static const id_at_title:OIDType = oid(id_at,12);
    public static const id_at_name:OIDType = oid(id_at,41);
    public static const id_at_givenName:OIDType = oid(id_at,42);
    public static const id_at_initials:OIDType = oid(id_at,43);
    public static const id_at_generationQualifier:OIDType = oid(id_at,44);
    public static const id_at_dnQualifier:OIDType = oid(id_at,46);
    public static const member_body:String = "2";
    public static const us:String = "840";
    public static const rsadsi:String = "113549";
    public static const pkcs:String = "1";
    public static const x9_57:String = "10040";
    public static const x9algorithm:String = "4";
    public static const ansi_x942:String = "10046";
    public static const number_type:String = "2";
    public static const pkcs_1:OIDType = oid(iso,member_body,us,rsadsi,pkcs,1);
    public static const rsaEncryption:OIDType = oid(pkcs_1,1);
    public static const md2WithRSAEncryption:OIDType = oid(pkcs_1,2);
    public static const md5WithRSAEncryption:OIDType = oid(pkcs_1,4);
    public static const sha1WithRSAEncryption:OIDType = oid(pkcs_1,5);
    public static const id_dsa_with_sha1:OIDType = oid(iso,member_body,us,x9_57,x9algorithm,3);
    public static const Dss_Sig_Value:ASN1Type = sequence({"r":integer()},{"s":integer()});
    public static const dhpublicnumber:OIDType = oid(iso,member_body,us,ansi_x942,number_type,1);
    public static const ValidationParms:ASN1Type = sequence({"seed":bitString()},{"pgenCounter":integer()});
    public static const DomainParameters:ASN1Type = sequence({"p":integer()},{"g":integer()},{"q":integer()},{"j":optional(integer())},{"validationParms":optional(ValidationParms)});
    public static const id_dsa:OIDType = oid(iso,member_body,us,x9_57,x9algorithm,1);
    public static const Dss_Parms:ASN1Type = sequence({"p":integer()},{"q":integer()},{"g":integer()});

    public static function Attribute(param1:ASN1Type, param2:OIDType):ASN1Type {
      return sequence({"type":param2},{"values":setOf(param1,1,MAX)});
    }
    public static const Version:ASN1Type = integer();
    public static const Extension:ASN1Type = sequence({"extnId":oid()},{"critical":defaultValue(false,boolean())},{"extnValue":octetString()});
    public static const Extensions:ASN1Type = sequenceOf(Extension,1,MAX);
    public static const UniqueIdentifier:ASN1Type = bitString();
    public static const CertificateSerialNumber:ASN1Type = integer();

    public static function directoryString(param1:int):ASN1Type {
      return choice({"teletexString":teletexString(1,param1)},{"printableString":printableString(1,param1)},{"universalString":universalString(1,param1)},{"bmpString":bmpString(1,param1)},{"utf8String":utf8String(1,param1)});
    }
    public static function pkcs9string(param1:int):ASN1Type {
      return choice({"utf8String":utf8String(1,param1)},{"directoryString":directoryString(param1)});
    }
    public static const AttributeTypeAndValue:ASN1Type = choice({"name":sequence({"type":id_at_name},{"value":directoryString(ub_name)})},{"commonName":sequence({"type":id_at_commonName},{"value":directoryString(ub_common_name)})},{"surname":sequence({"type":id_at_surname},{"value":directoryString(ub_name)})},{"givenName":sequence({"type":id_at_givenName},{"value":directoryString(ub_name)})},{"initials":sequence({"type":id_at_initials},{"value":directoryString(ub_name)})},{"generationQualifier":sequence({"type":id_at_generationQualifier},{"value":directoryString(ub_name)})},{"dnQualifier":sequence({"type":id_at_dnQualifier},{"value":printableString()})},{"countryName":sequence({"type":id_at_countryName},{"value":printableString(2)})},{"localityName":sequence({"type":id_at_localityName},{"value":directoryString(ub_locality_name)})},{"stateOrProvinceName":sequence({"type":id_at_stateOrProvinceName},{"value":directoryString(ub_state_name)})},{"organizationName":sequence({"type":id_at_organizationName}
    ,{"value":directoryString(ub_organization_name)})},{"organizationalUnitName":sequence({"type":id_at_organizationalUnitName},{"value":directoryString(ub_organizational_unit_name)})},{"title":sequence({"type":id_at_title},{"value":directoryString(ub_title)})},{"pkcs9email":sequence({"type":emailAddress},{"value":ia5String(ub_emailaddress_length)})},{"pkcs9UnstructuredName":sequence({"type":pkcs9_unstructuredName},{"value":pkcs9string(ub_pkcs9_string)})});
    public static const RelativeDistinguishedName:ASN1Type = setOf(AttributeTypeAndValue,1,MAX);
    public static const RDNSequence:ASN1Type = sequenceOf(RelativeDistinguishedName);
    public static const Name:ASN1Type = choice({"sequence":RDNSequence});
    public static const Time:ASN1Type = choice({"utcTime":utcTime()},{"generalTime":generalizedTime()});
    public static const Validity:ASN1Type = sequence({"notBefore":Time},{"notAfter":Time});
    public static const AlgorithmIdentifier:ASN1Type = sequence({"algorithm":oid()},{"parameters":optional(choice({"none":nulll()},{"dss_parms":Dss_Parms},{"domainParameters":DomainParameters}))});
    public static const SubjectPublicKeyInfo:ASN1Type = sequence({"algorithm":AlgorithmIdentifier},{"subjectPublicKey":bitString()});

    public static function signed(param1:ASN1Type):ASN1Type {
      return sequence({"toBeSigned":extract(param1)},{"algorithm":AlgorithmIdentifier},{"signature":bitString()});
    }
    public static const Certificate:ASN1Type = signed(sequence({"version":explicitTag(0,ASN1Type.CONTEXT,defaultValue(0,Version))},{"serialNumber":CertificateSerialNumber},{"signature":AlgorithmIdentifier},{"issuer":extract(Name)},{"validity":Validity},{"subject":extract(Name)},{"subjectPublicKeyInfo":SubjectPublicKeyInfo},{"issuerUniqueIdentifier":implicitTag(1,ASN1Type.CONTEXT,optional(UniqueIdentifier))},{"subjectUniqueIdentifier":implicitTag(2,ASN1Type.CONTEXT,optional(UniqueIdentifier))},{"extensions":explicitTag(3,ASN1Type.CONTEXT,optional(Extensions))}));

    public function Type2() {
      super();
    }
  }
}
