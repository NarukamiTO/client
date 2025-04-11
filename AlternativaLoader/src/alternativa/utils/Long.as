package alternativa.utils {
  public final class Long {
    private var _low:uint;
    private var _high:uint;

    public function Long(param1:uint, param2:uint) {
      super();
      this._high = param1;
      this._low = param2;
    }

    private function get low() : int {
      return this._low;
    }

    private function get high() : uint {
      return this._high;
    }

    public function toOct() : String {
      var local4:uint = 0;
      var local5:uint = 0;
      var local1:String = "";
      var local2:String = "";
      var local3:uint = 63;
      var local6:uint = 0;
      var local7:int = 0;
      while(local7 < 5) {
        local4 = uint((this.high & local3 << 4 + local6) >>> local6 + 4);
        local5 = uint((this.low & local3 << local6) >>> local6);
        local1 = this._toOct(local4) + local1;
        local2 = this._toOct(local5) + local2;
        local6 += 6;
        local7++;
      }
      var local8:String = local1 + this._toOct(((this.high & uint(15)) << 2) + (this.low >>> 30)) + local2;
      return this.trimLeadingZeros(local8);
    }

    private function trimLeadingZeros(param1:String) : String {
      var local2:int = 0;
      while(local2 < param1.length && param1.charAt(local2) == "0") {
        local2++;
      }
      return param1.substr(local2);
    }

    private function _toOct(param1:uint) : String {
      var local2:String = param1.toString(8);
      return (local2.length < 2 ? "0" : "") + local2;
    }
  }
}
