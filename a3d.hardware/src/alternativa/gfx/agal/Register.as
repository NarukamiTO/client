package alternativa.gfx.agal {
  import flash.utils.ByteArray;

  public class Register {
    protected var parent:Register;
    protected var swizzle:int = 228;
    protected var destMask:int = 15;
    protected var index:int;
    protected var emitCode:int;
    protected var relOffset:int;
    protected var relType:int;
    protected var relSel:uint;

    public function Register() {
      super();
    }

    public static function get(param1:int = 228, param2:int = 15, param3:Register = null) : Register {
      var local4:Register = new Register();
      local4.parent = param3;
      if(param3 != null) {
        local4.index = param3.index;
        local4.emitCode = param3.emitCode;
      }
      local4.swizzle = param1;
      local4.destMask = param2;
      return local4;
    }

    protected static function getSwizzle(param1:int = 0, param2:int = 1, param3:int = 2, param4:int = 3) : int {
      return param1 | param2 << 2 | param3 << 4 | param4 << 6;
    }

    protected static function getDestMask(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : int {
      var local5:int = 0;
      if(param1) {
        local5 |= 1;
      }
      if(param2) {
        local5 |= 2;
      }
      if(param3) {
        local5 |= 4;
      }
      if(param4) {
        local5 |= 8;
      }
      return local5;
    }

    public function writeDest(param1:ByteArray) : void {
      param1.writeShort(this.parent != null ? this.parent.index : this.index);
      param1.writeByte(this.destMask);
      param1.writeByte(this.parent != null ? this.parent.emitCode : this.emitCode);
    }

    public function writeSource(param1:ByteArray) : void {
      param1.writeShort(this.parent != null ? this.parent.index : this.index);
      param1.writeByte(this.parent != null ? this.parent.relOffset : this.relOffset);
      param1.writeByte(this.swizzle);
      param1.writeByte(this.parent != null ? this.parent.emitCode : this.emitCode);
      param1.writeByte(this.parent != null ? this.parent.relType : this.relType);
      param1.writeShort(this.parent != null ? int(this.parent.relSel) : int(this.relSel));
    }

    protected function relate(param1:Register, param2:uint) : void {
      this.relType = param1.emitCode;
      this.index = param1.index;
      if((param1.destMask & param1.destMask - 1) != 0) {
        throw new Error("Register must has simple swizzle: .x, .y, .z, .w");
      }
      this.relSel = Math.log(param1.destMask) / Math.LN2;
      this.relSel |= 1 << 15;
      this.relOffset = param2;
    }
  }
}
