package alternativa.protocol {
  import flash.utils.ByteArray;

  public class OptionalMap {
    private var readPosition:int;
    private var size:int;
    private var map:ByteArray;

    public function OptionalMap(param1:int = 0, param2:ByteArray = null) {
      super();
      this.init(param1,param2);
    }

    public function getReadPosition() : int {
      return this.readPosition;
    }

    public function setReadPosition(param1:int) : void {
      this.readPosition = param1;
    }

    public function reset() : void {
      this.readPosition = 0;
    }

    public function init(param1:int = 0, param2:ByteArray = null) : void {
      this.map = param2;
      if(param2 == null) {
        this.map = new ByteArray();
      } else {
        this.map.position = 0;
      }
      this.size = param1;
      this.readPosition = 0;
    }

    public function clear() : void {
      this.size = 0;
      this.readPosition = 0;
    }

    public function addBit(param1:Boolean) : void {
      this.setBit(this.size,param1);
      ++this.size;
    }

    public function hasNextBit() : Boolean {
      return this.readPosition < this.size;
    }

    public function get() : Boolean {
      if(this.readPosition >= this.size) {
        throw new Error("Index out of bounds: " + this.readPosition);
      }
      var local1:Boolean = this.getBit(this.readPosition);
      ++this.readPosition;
      return local1;
    }

    public function getMap() : ByteArray {
      return this.map;
    }

    public function getSize() : int {
      return this.size;
    }

    private function getBit(param1:int) : Boolean {
      var local2:int = param1 >> 3;
      var local3:int = 7 ^ param1 & 7;
      this.map.position = local2;
      return (this.map.readByte() & 1 << local3) != 0;
    }

    private function setBit(param1:int, param2:Boolean) : void {
      var local3:int = param1 >> 3;
      var local4:int = 7 ^ param1 & 7;
      this.map.position = local3;
      if(param2) {
        this.map.writeByte(int(this.map[local3] | 1 << local4));
      } else {
        this.map.writeByte(int(this.map[local3] & (0xFF ^ 1 << local4)));
      }
    }

    private function convertSize(param1:int) : int {
      var local2:int = param1 >> 3;
      var local3:int = (param1 & 7) == 0 ? 0 : 1;
      return local2 + local3;
    }

    public function toString() : String {
      var local1:String = "readPosition: " + this.readPosition + " size:" + this.getSize() + " mask:";
      var local2:int = this.readPosition;
      var local3:int = this.readPosition;
      while(local3 < this.getSize()) {
        local1 += this.get() ? "1" : "0";
        local3++;
      }
      this.readPosition = local2;
      return local1;
    }

    public function clone() : OptionalMap {
      var local1:ByteArray = new ByteArray();
      local1.writeBytes(this.map,0,this.convertSize(this.size));
      var local2:OptionalMap = new OptionalMap(this.size,local1);
      local2.readPosition = this.readPosition;
      return local2;
    }
  }
}
