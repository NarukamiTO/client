package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class ASN1Type {
    public static const CHOICE:int = -2;
    public static const ANY:int = -1;
    public static const RESERVED:int = 0;
    public static const BOOLEAN:int = 1;
    public static const INTEGER:int = 2;
    public static const BIT_STRING:int = 3;
    public static const OCTET_STRING:int = 4;
    public static const NULL:int = 5;
    public static const OID:int = 6;
    public static const ODT:int = 7;
    public static const EXTERNAL:int = 8;
    public static const REAL:int = 9;
    public static const ENUMERATED:int = 10;
    public static const EMBEDDED:int = 11;
    public static const UTF8STRING:int = 12;
    public static const ROID:int = 13;
    public static const SEQUENCE:int = 16;
    public static const SET:int = 17;
    public static const NUMERIC_STRING:int = 18;
    public static const PRINTABLE_STRING:int = 19;
    public static const TELETEX_STRING:int = 20;
    public static const VIDEOTEX_STRING:int = 21;
    public static const IA5_STRING:int = 22;
    public static const UTC_TIME:int = 23;
    public static const GENERALIZED_TIME:int = 24;
    public static const GRAPHIC_STRING:int = 25;
    public static const VISIBLE_STRING:int = 26;
    public static const GENERAL_STRING:int = 27;
    public static const UNIVERSAL_STRING:int = 28;
    public static const BMP_STRING:int = 30;
    public static const UNSTRUCTURED_NAME:int = 31;
    public static const UNIVERSAL:int = 0;
    public static const APPLICATION:int = 1;
    public static const CONTEXT:int = 2;
    public static const PRIVATE:int = 3;

    registerClassAlias("com.hurlant.util.asn1.ASN1Type",ASN1Type);

    public var optional:Boolean = false;
    public var implicitTag:Number = NaN;
    public var implicitClass:int = 0;
    public var explicitTag:Number = NaN;
    public var explicitClass:int = 0;
    public var defaultValue:* = null;
    public var extract:Boolean = false;
    public var defaultTag:Number;
    public var parsedTag:Number;

    public function ASN1Type(param1:int) {
      super();
      this.defaultTag = param1;
    }

    public function matches(param1:int, param2:int, param3:int) : Boolean {
      return false;
    }

    public function clone() : ASN1Type {
      var local1:ByteArray = new ByteArray();
      local1.writeObject(this);
      local1.position = 0;
      return local1.readObject();
    }

    public function fromDER(param1:ByteArray, param2:int) : * {
      var local4:int = 0;
      var local5:* = undefined;
      var local6:int = 0;
      var local3:int = int(param1.position);
      if(!isNaN(this.explicitTag)) {
        local6 = this.readDERTag(param1,this.explicitClass,true);
        if(local6 == this.explicitTag) {
          local4 = this.readDERLength(param1);
        }
        addr96:
        param1.position = local3;
        if(this.defaultValue != null) {
          return this.fromDefaultValue();
        }
        return null;
      }
      if(!isNaN(this.implicitTag)) {
        local6 = this.readDERTag(param1,this.implicitClass);
        if(local6 != this.implicitTag) {
        }
        §§goto(addr96);
      } else {
        local6 = this.readDERTag(param1);
        if(this.defaultTag == ANY) {
          this.parsedTag = local6;
        } else {
          if(local6 != this.defaultTag) {
          }
          §§goto(addr96);
        }
      }
      local4 = this.readDERLength(param1);
      local5 = this.fromDERContent(param1,local4);
      if(local5 != null) {
        return local5;
      }
      §§goto(addr96);
    }

    protected function fromDefaultValue() : * {
      return this.defaultValue;
    }

    protected function fromDERContent(param1:ByteArray, param2:int) : * {
      throw new Error("pure virtual function call: fromDERContent");
    }

    protected function readDERTag(param1:ByteArray, param2:int = 0, param3:Boolean = false, param4:Boolean = false) : int {
      var local8:int = 0;
      var local9:int = 0;
      var local5:int = int(param1.readUnsignedByte());
      var local6:Boolean = (local5 & 0x20) != 0;
      var local7:int = (local5 & 0xC0) >> 6;
      local5 &= 31;
      if(local5 == 31) {
        local5 = 0;
        do {
          local8 = int(param1.readUnsignedByte());
          local9 = local8 & 0x7F;
          local5 = (local5 << 7) + local9;
        }
        while(Boolean(local8 & 128 != 0));
      }
      if(param2 != local7) {
      }
      return local5;
    }

    protected function readDERLength(param1:ByteArray) : int {
      var local3:int = 0;
      var local2:int = int(param1.readUnsignedByte());
      if(local2 >= 128) {
        local3 = local2 & 0x7F;
        local2 = 0;
        while(local3 > 0) {
          local2 = local2 << 8 | param1.readUnsignedByte();
          local3--;
        }
      }
      return local2;
    }
  }
}
