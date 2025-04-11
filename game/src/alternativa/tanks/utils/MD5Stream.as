package alternativa.tanks.utils {
  import flash.utils.ByteArray;

  public class MD5Stream {
    private static var mask:int = 255;

    private var arr:Array = [];
    private var arrLen:int;
    private var a:int = 1732584193;
    private var b:int = -271733879;
    private var c:int = -1732584194;
    private var d:int = 271733878;
    private var aa:int;
    private var bb:int;
    private var cc:int;
    private var dd:int;
    private var arrIndexLen:int = 0;
    private var arrProcessIndex:int = 0;
    private var cleanIndex:int = 0;

    public var memoryBlockSize:int = 16384;

    public function MD5Stream() {
      super();
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function f(param1:int, param2:int, param3:int) : int {
      return param1 & param2 | ~param1 & param3;
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function g(param1:int, param2:int, param3:int) : int {
      return param1 & param3 | param2 & ~param3;
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function h(param1:int, param2:int, param3:int) : int {
      return param1 ^ param2 ^ param3;
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function i(param1:int, param2:int, param3:int) : int {
      return param2 ^ (param1 | ~param3);
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function transform(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : int {
      var local9:int = param2 + int(param1(param3,param4,param5)) + param6 + param8;
      return IntUtil.rol(local9,param7) + param3;
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function ff(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int {
      return transform(f,param1,param2,param3,param4,param5,param6,param7);
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function gg(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int {
      return transform(g,param1,param2,param3,param4,param5,param6,param7);
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function hh(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int {
      return transform(h,param1,param2,param3,param4,param5,param6,param7);
    }

    [Obfuscation(statementLevelRandomization="true")]
    private static function ii(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int {
      return transform(i,param1,param2,param3,param4,param5,param6,param7);
    }

    [Obfuscation(statementLevelRandomization="true")]
    public function complete(param1:ByteArray = null) : Vector.<int> {
      if(this.arr.length == 0) {
        if(param1 == null) {
          throw new Error();
        }
      }
      if(param1 != null) {
        this.readIntoArray(param1);
      }
      this.padArray(this.arrLen);
      this.hashRemainingChunks(false);
      var local2:Vector.<int> = Vector.<int>([this.a,this.b,this.c,this.d]);
      this.resetFields();
      return local2;
    }

    [Obfuscation(statementLevelRandomization="true")]
    public function update(param1:ByteArray) : void {
      this.readIntoArray(param1);
      this.hashRemainingChunks();
    }

    [Obfuscation(statementLevelRandomization="true")]
    public function resetFields() : void {
      this.arr.length = 0;
      this.arrLen = 0;
      this.a = 1732584193;
      this.b = -271733879;
      this.c = -1732584194;
      this.d = 271733878;
      this.aa = 0;
      this.bb = 0;
      this.cc = 0;
      this.dd = 0;
      this.arrIndexLen = 0;
      this.arrProcessIndex = 0;
      this.cleanIndex = 0;
    }

    [Obfuscation(statementLevelRandomization="true")]
    private function readIntoArray(param1:ByteArray) : void {
      var local4:Array = null;
      var local5:int = 0;
      var local2:int = param1.length * 8;
      this.arrLen += local2;
      if(this.arrProcessIndex - this.cleanIndex > this.memoryBlockSize) {
        local4 = new Array();
        local5 = this.arrProcessIndex;
        while(local5 < this.arr.length) {
          local4[local5] = this.arr[local5];
          local5++;
        }
        this.cleanIndex = this.arrProcessIndex;
        this.arr = null;
        this.arr = local4;
      }
      var local3:int = 0;
      while(local3 < local2) {
        this.arr[int(this.arrIndexLen >> 5)] = this.arr[int(this.arrIndexLen >> 5)] | (param1[local3 / 8] & mask) << this.arrIndexLen % 32;
        this.arrIndexLen += 8;
        local3 += 8;
      }
    }

    [Obfuscation(statementLevelRandomization="true")]
    private function hashRemainingChunks(param1:Boolean = true) : void {
      var local2:int = int(this.arr.length);
      if(param1) {
        local2 -= 16;
      }
      if(this.arrProcessIndex >= local2 || local2 - this.arrProcessIndex < 15) {
        return;
      }
      var local3:int = this.arrProcessIndex;
      while(local3 < local2) {
        this.aa = this.a;
        this.bb = this.b;
        this.cc = this.c;
        this.dd = this.d;
        this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(local3 + 0)],7,-680876936);
        this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(local3 + 1)],12,-389564586);
        this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(local3 + 2)],17,606105819);
        this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(local3 + 3)],22,-1044525330);
        this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(local3 + 4)],7,-176418897);
        this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(local3 + 5)],12,1200080426);
        this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(local3 + 6)],17,-1473231341);
        this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(local3 + 7)],22,-45705983);
        this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(local3 + 8)],7,1770035416);
        this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(local3 + 9)],12,-1958414417);
        this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(local3 + 10)],17,-42063);
        this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(local3 + 11)],22,-1990404162);
        this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(local3 + 12)],7,1804603682);
        this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(local3 + 13)],12,-40341101);
        this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(local3 + 14)],17,-1502002290);
        this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(local3 + 15)],22,1236535329);
        this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(local3 + 1)],5,-165796510);
        this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(local3 + 6)],9,-1069501632);
        this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(local3 + 11)],14,643717713);
        this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(local3 + 0)],20,-373897302);
        this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(local3 + 5)],5,-701558691);
        this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(local3 + 10)],9,38016083);
        this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(local3 + 15)],14,-660478335);
        this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(local3 + 4)],20,-405537848);
        this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(local3 + 9)],5,568446438);
        this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(local3 + 14)],9,-1019803690);
        this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(local3 + 3)],14,-187363961);
        this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(local3 + 8)],20,1163531501);
        this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(local3 + 13)],5,-1444681467);
        this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(local3 + 2)],9,-51403784);
        this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(local3 + 7)],14,1735328473);
        this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(local3 + 12)],20,-1926607734);
        this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(local3 + 5)],4,-378558);
        this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(local3 + 8)],11,-2022574463);
        this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(local3 + 11)],16,1839030562);
        this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(local3 + 14)],23,-35309556);
        this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(local3 + 1)],4,-1530992060);
        this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(local3 + 4)],11,1272893353);
        this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(local3 + 7)],16,-155497632);
        this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(local3 + 10)],23,-1094730640);
        this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(local3 + 13)],4,681279174);
        this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(local3 + 0)],11,-358537222);
        this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(local3 + 3)],16,-722521979);
        this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(local3 + 6)],23,76029189);
        this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(local3 + 9)],4,-640364487);
        this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(local3 + 12)],11,-421815835);
        this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(local3 + 15)],16,530742520);
        this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(local3 + 2)],23,-995338651);
        this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(local3 + 0)],6,-198630844);
        this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(local3 + 7)],10,1126891415);
        this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(local3 + 14)],15,-1416354905);
        this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(local3 + 5)],21,-57434055);
        this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(local3 + 12)],6,1700485571);
        this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(local3 + 3)],10,-1894986606);
        this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(local3 + 10)],15,-1051523);
        this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(local3 + 1)],21,-2054922799);
        this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(local3 + 8)],6,1873313359);
        this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(local3 + 15)],10,-30611744);
        this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(local3 + 6)],15,-1560198380);
        this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(local3 + 13)],21,1309151649);
        this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(local3 + 4)],6,-145523070);
        this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(local3 + 11)],10,-1120210379);
        this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(local3 + 2)],15,718787259);
        this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(local3 + 9)],21,-343485551);
        this.a += this.aa;
        this.b += this.bb;
        this.c += this.cc;
        this.d += this.dd;
        local3 += 16;
        this.arrProcessIndex += 16;
      }
    }

    [Obfuscation(statementLevelRandomization="true")]
    private function padArray(param1:int) : void {
      this.arr[int(param1 >> 5)] = this.arr[int(param1 >> 5)] | 128 << param1 % 32;
      this.arr[int((param1 + 64 >>> 9 << 4) + 14)] = param1;
      this.arrLen = this.arr.length;
    }
  }
}
