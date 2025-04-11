package alternativa.tanks.utils {
  public class BitVector {
    private var elements:Vector.<int>;

    public function BitVector(param1:uint) {
      super();
      this.elements = new Vector.<int>(param1 >> 5,true);
    }

    public function setBit(param1:int) : void {
      var local2:int = param1 >> 5;
      this.elements[local2] |= 1 << (param1 & 0x1F);
    }

    public function clearBit(param1:int) : void {
      var local2:int = param1 >> 5;
      this.elements[local2] &= ~(1 << (param1 & 0x1F));
    }

    public function getBit(param1:int) : int {
      var local2:int = param1 >> 5;
      return this.elements[local2] >> (param1 & 0x1F) & 1;
    }

    public function clear() : void {
      var local1:int = 0;
      while(local1 < this.elements.length) {
        this.elements[local1] = 0;
        local1++;
      }
    }
  }
}
