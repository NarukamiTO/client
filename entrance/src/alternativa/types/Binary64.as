package alternativa.types {
  public class Binary64 {
    public var low:uint;

    internal var internalHigh:uint;

    public function Binary64(param1:uint = 0, param2:uint = 0) {
      super();
      this.low = param1;
      this.internalHigh = param2;
    }

    final internal function div(param1:uint) : uint {
      var local2:uint = 0;
      local2 = this.internalHigh % param1;
      var local3:uint = (this.low % param1 + local2 * 6) % param1;
      this.internalHigh /= param1;
      var local4:Number = (local2 * Number(4294967296) + this.low) / param1;
      this.internalHigh += local4 / 4294967296;
      this.low = local4;
      return local3;
    }

    final internal function mul(param1:uint) : void {
      var local2:Number = Number(this.low) * param1;
      this.internalHigh = local2 / 4294967296 + Number(this.internalHigh) * param1;
      this.low = local2;
    }

    final internal function add(param1:uint) : void {
      var local2:Number = Number(this.low) + param1;
      this.internalHigh = local2 / 4294967296 + this.internalHigh;
      this.low = local2;
    }

    final internal function bitwiseNot() : void {
      this.low = ~this.low;
      this.internalHigh = ~this.internalHigh;
    }
  }
}
