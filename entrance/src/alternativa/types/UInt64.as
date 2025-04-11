package alternativa.types {
  public class UInt64 extends Binary64 {
    public function UInt64(param1:uint = 0, param2:uint = 0) {
      super(param1,param2);
    }

    public static function parseUInt64(param1:String, param2:uint = 0) : UInt64 {
      var local5:uint = 0;
      var local3:uint = 0;
      if(param2 == 0) {
        if(param1.search(/^0x/) == 0) {
          param2 = 16;
          local3 = 2;
        } else {
          param2 = 10;
        }
      }
      if(param2 < 2 || param2 > 36) {
        throw new ArgumentError();
      }
      param1 = param1.toLowerCase();
      var local4:UInt64 = new UInt64();
      while(local3 < param1.length) {
        local5 = uint(param1.charCodeAt(local3));
        if(local5 >= "0".charCodeAt() && local5 <= "9".charCodeAt()) {
          local5 -= "0".charCodeAt();
        } else {
          if(!(local5 >= "a".charCodeAt() && local5 <= "z".charCodeAt())) {
            throw new ArgumentError();
          }
          local5 -= "a".charCodeAt();
        }
        if(local5 >= param2) {
          throw new ArgumentError();
        }
        local4.mul(param2);
        local4.add(local5);
        local3++;
      }
      return local4;
    }

    final public function set high(param1:uint) : void {
      internalHigh = param1;
    }

    final public function get high() : uint {
      return internalHigh;
    }

    final public function toNumber() : Number {
      return this.high * 4294967296 + low;
    }

    final public function toString(param1:uint = 10) : String {
      var local4:uint = 0;
      if(param1 < 2 || param1 > 36) {
        throw new ArgumentError();
      }
      if(this.high == 0) {
        return low.toString(param1);
      }
      var local2:Array = [];
      var local3:UInt64 = new UInt64(low,this.high);
      do {
        local4 = uint(local3.div(param1));
        local2.push((local4 < 10 ? "0" : "a").charCodeAt() + local4);
      }
      while(local3.high != 0);
      return local3.low.toString(param1) + String.fromCharCode.apply(String,local2.reverse());
    }
  }
}
