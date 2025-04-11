package alternativa.tanks.utils {
  public class BitMask {
    private var mask:int;

    public function BitMask(param1:int = 0) {
      super();
      this.mask = param1;
    }

    public function getMask() : int {
      return this.mask;
    }

    public function setBits(param1:int) : void {
      this.mask |= param1;
    }

    public function clearBits(param1:int) : void {
      this.mask &= ~param1;
    }

    public function setBit(param1:int) : void {
      this.setBits(1 << param1);
    }

    public function clearBit(param1:int) : void {
      this.clearBits(1 << param1);
    }

    public function getBitValue(param1:int) : int {
      return 1 & this.mask >> param1;
    }

    public function clear() : void {
      this.mask = 0;
    }

    public function isEmpty() : Boolean {
      return this.mask == 0;
    }

    public function isNotEmpty() : Boolean {
      return this.mask != 0;
    }

    public function hasAnyBit(param1:int) : Boolean {
      return (this.mask & param1) != 0;
    }

    public function change(param1:int, param2:Boolean) : void {
      if(param2) {
        this.setBits(param1);
      } else {
        this.clearBits(param1);
      }
    }
  }
}
