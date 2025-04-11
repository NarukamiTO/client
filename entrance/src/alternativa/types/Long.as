package alternativa.types {
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;

  public final class Long {
    private static var longMap:Dictionary = new Dictionary();

    public static const ZERO:Long = getLong(0,0);

    private var _low:int;
    private var _high:int;

    public function Long(param1:int, param2:int) {
      super();
      this._high = param1;
      this._low = param2;
    }

    public static function getLong(param1:int, param2:int) : Long {
      var local3:Long = null;
      var local4:Dictionary = longMap[param2];
      if(local4 != null) {
        local3 = local4[param1];
        if(local3 == null) {
          local3 = new Long(param1,param2);
          local4[param1] = local3;
        }
      } else {
        longMap[param2] = new Dictionary();
        local3 = new Long(param1,param2);
        longMap[param2][param1] = local3;
      }
      return local3;
    }

    public static function fromHexString(param1:String) : Long {
      var local2:int = param1.length;
      if(local2 <= 8) {
        return getLong(0,int("0x" + param1));
      }
      return getLong(int("0x" + param1.substr(0,local2 - 8)),int("0x" + param1.substr(local2 - 8)));
    }

    public static function fromInt(param1:int) : Long {
      if(param1 < 0) {
        return getLong(4294967295,param1);
      }
      return getLong(0,param1);
    }

    public static function comparator(param1:Long, param2:Long) : int {
      if(param1 == param2) {
        return 0;
      }
      if(param1.high != param2.high) {
        return param1.high < param2.high ? -1 : 1;
      }
      if(param1.low != param2.low) {
        return param1.low < param2.low ? -1 : 1;
      }
      return 0;
    }

    public function get low() : int {
      return this._low;
    }

    public function get high() : int {
      return this._high;
    }

    final public function toString(param1:uint = 10) : String {
      var local4:uint = 0;
      if(param1 < 2 || param1 > 36) {
        throw new ArgumentError();
      }
      switch(this.high) {
        case 0:
          return this.low.toString(param1);
        case -1:
          return int(this.low).toString(param1);
        default:
          if(this.low == 0 && this.high == 0) {
            return "0";
          }
          var local2:Array = [];
          var local3:UInt64 = new UInt64(this.low,this.high);
          if(this.high < 0) {
            local3.bitwiseNot();
            local3.add(1);
          }
          do {
            local4 = uint(local3.div(param1));
            local2.push((local4 < 10 ? "0" : "a").charCodeAt() + local4);
          }
          while(local3.high != 0);
          if(this.high < 0) {
            return "-" + local3.low.toString(param1) + String.fromCharCode.apply(String,local2.reverse());
          }
          return local3.low.toString(param1) + String.fromCharCode.apply(String,local2.reverse());
      }
    }

    public function toByteArray(param1:ByteArray = null) : ByteArray {
      if(param1 == null) {
        param1 = new ByteArray();
      }
      param1.position = 0;
      param1.writeInt(this._high);
      param1.writeInt(this._low);
      param1.position = 0;
      return param1;
    }
  }
}
