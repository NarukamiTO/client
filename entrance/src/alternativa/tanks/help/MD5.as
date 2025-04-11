package alternativa.tanks.help {
  public class MD5 {
    public static const HEX_FORMAT_LOWERCASE:uint = 0;
    public static const HEX_FORMAT_UPPERCASE:uint = 1;
    public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
    public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";

    public static var hexcase:uint = 0;
    public static var b64pad:String = "";

    public function MD5() {
      super();
    }

    public static function encrypt(param1:String) : String {
      return hex_md5(param1);
    }

    public static function hex_md5(param1:String) : String {
      return rstr2hex(rstr_md5(str2rstr_utf8(param1)));
    }

    public static function b64_md5(param1:String) : String {
      return rstr2b64(rstr_md5(str2rstr_utf8(param1)));
    }

    public static function any_md5(param1:String, param2:String) : String {
      return rstr2any(rstr_md5(str2rstr_utf8(param1)),param2);
    }

    public static function hex_hmac_md5(param1:String, param2:String) : String {
      return rstr2hex(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)));
    }

    public static function b64_hmac_md5(param1:String, param2:String) : String {
      return rstr2b64(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)));
    }

    public static function any_hmac_md5(param1:String, param2:String, param3:String) : String {
      return rstr2any(rstr_hmac_md5(str2rstr_utf8(param1),str2rstr_utf8(param2)),param3);
    }

    public static function md5_vm_test() : Boolean {
      return hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
    }

    public static function rstr_md5(param1:String) : String {
      return binl2rstr(binl_md5(rstr2binl(param1),param1.length * 8));
    }

    public static function rstr_hmac_md5(param1:String, param2:String) : String {
      var local3:Array = rstr2binl(param1);
      if(local3.length > 16) {
        local3 = binl_md5(local3,param1.length * 8);
      }
      var local4:Array = new Array(16);
      var local5:Array = new Array(16);
      var local6:Number = 0;
      while(local6 < 16) {
        local4[local6] = local3[local6] ^ 0x36363636;
        local5[local6] = local3[local6] ^ 0x5C5C5C5C;
        local6++;
      }
      var local7:Array = binl_md5(local4.concat(rstr2binl(param2)),512 + param2.length * 8);
      return binl2rstr(binl_md5(local5.concat(local7),512 + 128));
    }

    public static function rstr2hex(param1:String) : String {
      var local4:Number = NaN;
      var local2:String = Boolean(hexcase) ? "0123456789ABCDEF" : "0123456789abcdef";
      var local3:String = "";
      var local5:Number = 0;
      while(local5 < param1.length) {
        local4 = Number(param1.charCodeAt(local5));
        local3 += local2.charAt(local4 >>> 4 & 0x0F) + local2.charAt(local4 & 0x0F);
        local5++;
      }
      return local3;
    }

    public static function rstr2b64(param1:String) : String {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local2:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      var local3:String = "";
      var local4:Number = param1.length;
      var local5:Number = 0;
      while(local5 < local4) {
        local6 = param1.charCodeAt(local5) << 16 | (local5 + 1 < local4 ? param1.charCodeAt(local5 + 1) << 8 : 0) | (local5 + 2 < local4 ? param1.charCodeAt(local5 + 2) : 0);
        local7 = 0;
        while(local7 < 4) {
          if(local5 * 8 + local7 * 6 > param1.length * 8) {
            local3 += b64pad;
          } else {
            local3 += local2.charAt(local6 >>> 6 * (3 - local7) & 0x3F);
          }
          local7++;
        }
        local5 += 3;
      }
      return local3;
    }

    public static function rstr2any(param1:String, param2:String) : String {
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Array = null;
      var local3:Number = param2.length;
      var local4:Array = [];
      var local9:Array = new Array(param1.length / 2);
      local5 = 0;
      while(local5 < local9.length) {
        local9[local5] = param1.charCodeAt(local5 * 2) << 8 | param1.charCodeAt(local5 * 2 + 1);
        local5++;
      }
      while(local9.length > 0) {
        local8 = [];
        local7 = 0;
        local5 = 0;
        while(local5 < local9.length) {
          local7 = (local7 << 16) + local9[local5];
          local6 = Math.floor(local7 / local3);
          local7 -= local6 * local3;
          if(local8.length > 0 || local6 > 0) {
            local8[local8.length] = local6;
          }
          local5++;
        }
        local4[local4.length] = local7;
        local9 = local8;
      }
      var local10:String = "";
      local5 = local4.length - 1;
      while(local5 >= 0) {
        local10 += param2.charAt(local4[local5]);
        local5--;
      }
      return local10;
    }

    public static function str2rstr_utf8(param1:String) : String {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local2:String = "";
      var local3:Number = -1;
      while(++local3 < param1.length) {
        local4 = Number(param1.charCodeAt(local3));
        local5 = local3 + 1 < param1.length ? Number(param1.charCodeAt(local3 + 1)) : 0;
        if(55296 <= local4 && local4 <= 56319 && 56320 <= local5 && local5 <= 57343) {
          local4 = 65536 + ((local4 & 0x03FF) << 10) + (local5 & 0x03FF);
          local3++;
        }
        if(local4 <= 127) {
          local2 += String.fromCharCode(local4);
        } else if(local4 <= 2047) {
          local2 += String.fromCharCode(0xC0 | local4 >>> 6 & 0x1F,0x80 | local4 & 0x3F);
        } else if(local4 <= 65535) {
          local2 += String.fromCharCode(0xE0 | local4 >>> 12 & 0x0F,0x80 | local4 >>> 6 & 0x3F,0x80 | local4 & 0x3F);
        } else if(local4 <= 2097151) {
          local2 += String.fromCharCode(0xF0 | local4 >>> 18 & 7,0x80 | local4 >>> 12 & 0x3F,0x80 | local4 >>> 6 & 0x3F,0x80 | local4 & 0x3F);
        }
      }
      return local2;
    }

    public static function str2rstr_utf16le(param1:String) : String {
      var local2:String = "";
      var local3:Number = 0;
      while(local3 < param1.length) {
        local2 += String.fromCharCode(param1.charCodeAt(local3) & 0xFF,param1.charCodeAt(local3) >>> 8 & 0xFF);
        local3++;
      }
      return local2;
    }

    public static function str2rstr_utf16be(param1:String) : String {
      var local2:String = "";
      var local3:Number = 0;
      while(local3 < param1.length) {
        local2 += String.fromCharCode(param1.charCodeAt(local3) >>> 8 & 0xFF,param1.charCodeAt(local3) & 0xFF);
        local3++;
      }
      return local2;
    }

    public static function rstr2binl(param1:String) : Array {
      var local2:Number = 0;
      var local3:Array = new Array(param1.length >> 2);
      local2 = 0;
      while(local2 < local3.length) {
        local3[local2] = 0;
        local2++;
      }
      local2 = 0;
      while(local2 < param1.length * 8) {
        local3[local2 >> 5] |= (param1.charCodeAt(local2 / 8) & 0xFF) << local2 % 32;
        local2 += 8;
      }
      return local3;
    }

    public static function binl2rstr(param1:Array) : String {
      var local2:String = "";
      var local3:Number = 0;
      while(local3 < param1.length * 32) {
        local2 += String.fromCharCode(param1[local3 >> 5] >>> local3 % 32 & 0xFF);
        local3 += 8;
      }
      return local2;
    }

    public static function binl_md5(param1:Array, param2:Number) : Array {
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      param1[param2 >> 5] |= 128 << param2 % 32;
      param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
      var local3:Number = 1732584193;
      var local4:Number = -271733879;
      var local5:Number = -1732584194;
      var local6:Number = 271733878;
      var local7:Number = 0;
      while(local7 < param1.length) {
        local8 = local3;
        local9 = local4;
        local10 = local5;
        local11 = local6;
        local3 = md5_ff(local3,local4,local5,local6,param1[local7 + 0],7,-680876936);
        local6 = md5_ff(local6,local3,local4,local5,param1[local7 + 1],12,-389564586);
        local5 = md5_ff(local5,local6,local3,local4,param1[local7 + 2],17,606105819);
        local4 = md5_ff(local4,local5,local6,local3,param1[local7 + 3],22,-1044525330);
        local3 = md5_ff(local3,local4,local5,local6,param1[local7 + 4],7,-176418897);
        local6 = md5_ff(local6,local3,local4,local5,param1[local7 + 5],12,1200080426);
        local5 = md5_ff(local5,local6,local3,local4,param1[local7 + 6],17,-1473231341);
        local4 = md5_ff(local4,local5,local6,local3,param1[local7 + 7],22,-45705983);
        local3 = md5_ff(local3,local4,local5,local6,param1[local7 + 8],7,1770035416);
        local6 = md5_ff(local6,local3,local4,local5,param1[local7 + 9],12,-1958414417);
        local5 = md5_ff(local5,local6,local3,local4,param1[local7 + 10],17,-42063);
        local4 = md5_ff(local4,local5,local6,local3,param1[local7 + 11],22,-1990404162);
        local3 = md5_ff(local3,local4,local5,local6,param1[local7 + 12],7,1804603682);
        local6 = md5_ff(local6,local3,local4,local5,param1[local7 + 13],12,-40341101);
        local5 = md5_ff(local5,local6,local3,local4,param1[local7 + 14],17,-1502002290);
        local4 = md5_ff(local4,local5,local6,local3,param1[local7 + 15],22,1236535329);
        local3 = md5_gg(local3,local4,local5,local6,param1[local7 + 1],5,-165796510);
        local6 = md5_gg(local6,local3,local4,local5,param1[local7 + 6],9,-1069501632);
        local5 = md5_gg(local5,local6,local3,local4,param1[local7 + 11],14,643717713);
        local4 = md5_gg(local4,local5,local6,local3,param1[local7 + 0],20,-373897302);
        local3 = md5_gg(local3,local4,local5,local6,param1[local7 + 5],5,-701558691);
        local6 = md5_gg(local6,local3,local4,local5,param1[local7 + 10],9,38016083);
        local5 = md5_gg(local5,local6,local3,local4,param1[local7 + 15],14,-660478335);
        local4 = md5_gg(local4,local5,local6,local3,param1[local7 + 4],20,-405537848);
        local3 = md5_gg(local3,local4,local5,local6,param1[local7 + 9],5,568446438);
        local6 = md5_gg(local6,local3,local4,local5,param1[local7 + 14],9,-1019803690);
        local5 = md5_gg(local5,local6,local3,local4,param1[local7 + 3],14,-187363961);
        local4 = md5_gg(local4,local5,local6,local3,param1[local7 + 8],20,1163531501);
        local3 = md5_gg(local3,local4,local5,local6,param1[local7 + 13],5,-1444681467);
        local6 = md5_gg(local6,local3,local4,local5,param1[local7 + 2],9,-51403784);
        local5 = md5_gg(local5,local6,local3,local4,param1[local7 + 7],14,1735328473);
        local4 = md5_gg(local4,local5,local6,local3,param1[local7 + 12],20,-1926607734);
        local3 = md5_hh(local3,local4,local5,local6,param1[local7 + 5],4,-378558);
        local6 = md5_hh(local6,local3,local4,local5,param1[local7 + 8],11,-2022574463);
        local5 = md5_hh(local5,local6,local3,local4,param1[local7 + 11],16,1839030562);
        local4 = md5_hh(local4,local5,local6,local3,param1[local7 + 14],23,-35309556);
        local3 = md5_hh(local3,local4,local5,local6,param1[local7 + 1],4,-1530992060);
        local6 = md5_hh(local6,local3,local4,local5,param1[local7 + 4],11,1272893353);
        local5 = md5_hh(local5,local6,local3,local4,param1[local7 + 7],16,-155497632);
        local4 = md5_hh(local4,local5,local6,local3,param1[local7 + 10],23,-1094730640);
        local3 = md5_hh(local3,local4,local5,local6,param1[local7 + 13],4,681279174);
        local6 = md5_hh(local6,local3,local4,local5,param1[local7 + 0],11,-358537222);
        local5 = md5_hh(local5,local6,local3,local4,param1[local7 + 3],16,-722521979);
        local4 = md5_hh(local4,local5,local6,local3,param1[local7 + 6],23,76029189);
        local3 = md5_hh(local3,local4,local5,local6,param1[local7 + 9],4,-640364487);
        local6 = md5_hh(local6,local3,local4,local5,param1[local7 + 12],11,-421815835);
        local5 = md5_hh(local5,local6,local3,local4,param1[local7 + 15],16,530742520);
        local4 = md5_hh(local4,local5,local6,local3,param1[local7 + 2],23,-995338651);
        local3 = md5_ii(local3,local4,local5,local6,param1[local7 + 0],6,-198630844);
        local6 = md5_ii(local6,local3,local4,local5,param1[local7 + 7],10,1126891415);
        local5 = md5_ii(local5,local6,local3,local4,param1[local7 + 14],15,-1416354905);
        local4 = md5_ii(local4,local5,local6,local3,param1[local7 + 5],21,-57434055);
        local3 = md5_ii(local3,local4,local5,local6,param1[local7 + 12],6,1700485571);
        local6 = md5_ii(local6,local3,local4,local5,param1[local7 + 3],10,-1894986606);
        local5 = md5_ii(local5,local6,local3,local4,param1[local7 + 10],15,-1051523);
        local4 = md5_ii(local4,local5,local6,local3,param1[local7 + 1],21,-2054922799);
        local3 = md5_ii(local3,local4,local5,local6,param1[local7 + 8],6,1873313359);
        local6 = md5_ii(local6,local3,local4,local5,param1[local7 + 15],10,-30611744);
        local5 = md5_ii(local5,local6,local3,local4,param1[local7 + 6],15,-1560198380);
        local4 = md5_ii(local4,local5,local6,local3,param1[local7 + 13],21,1309151649);
        local3 = md5_ii(local3,local4,local5,local6,param1[local7 + 4],6,-145523070);
        local6 = md5_ii(local6,local3,local4,local5,param1[local7 + 11],10,-1120210379);
        local5 = md5_ii(local5,local6,local3,local4,param1[local7 + 2],15,718787259);
        local4 = md5_ii(local4,local5,local6,local3,param1[local7 + 9],21,-343485551);
        local3 = safe_add(local3,local8);
        local4 = safe_add(local4,local9);
        local5 = safe_add(local5,local10);
        local6 = safe_add(local6,local11);
        local7 += 16;
      }
      return [local3,local4,local5,local6];
    }

    public static function md5_cmn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
      return safe_add(bit_rol(safe_add(safe_add(param2,param1),safe_add(param4,param6)),param5),param3);
    }

    public static function md5_ff(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
      return md5_cmn(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
    }

    public static function md5_gg(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
      return md5_cmn(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
    }

    public static function md5_hh(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
      return md5_cmn(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
    }

    public static function md5_ii(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Number {
      return md5_cmn(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
    }

    public static function safe_add(param1:Number, param2:Number) : Number {
      var local3:Number = (param1 & 0xFFFF) + (param2 & 0xFFFF);
      var local4:Number = (param1 >> 16) + (param2 >> 16) + (local3 >> 16);
      return local4 << 16 | local3 & 0xFFFF;
    }

    public static function bit_rol(param1:Number, param2:Number) : Number {
      return param1 << param2 | param1 >>> 32 - param2;
    }
  }
}
