package alternativa.tanks.models.tank.codec {
  public class BitArea {
    private var data:Array;
    private var length:int;
    private var position:int;

    public function BitArea(param1:Array, param2:int) {
      super();
      this.data = param1;
      this.position = 0;
      this.length = param2 * 8;
    }

    public function reset() : void {
      this.position = 0;
    }

    public function read(param1:int) : int {
      if(param1 > 32) {
        throw new Error("Cannot read more that 32 bit at once (requested " + param1 + ")");
      }
      if(this.position + param1 > this.length) {
        throw new Error("BitArea is out of data: requesed " + param1 + " bits, avaliable:" + (this.length - this.position));
      }
      var local2:int = 0;
      var local3:int = param1 - 1;
      while(local3 >= 0) {
        if(this.getBit(this.position)) {
          local2 += 1 << local3;
        }
        ++this.position;
        local3--;
      }
      return local2;
    }

    public function write(param1:int, param2:int) : void {
      var local4:Boolean = false;
      if(param1 > 32) {
        throw new Error("Cannot write more that 32 bit at once (requested " + param1 + ")");
      }
      if(this.position + param1 > this.length) {
        throw new Error("BitArea overflow attempt to write " + param1 + " bits, space avaliable:" + (this.length - this.position));
      }
      var local3:int = param1 - 1;
      while(local3 >= 0) {
        local4 = (param2 & 1 << local3) != 0;
        this.setBit(this.position,local4);
        ++this.position;
        local3--;
      }
    }

    private function arrayToHezString(param1:Array) : String {
      var local4:int = 0;
      var local2:String = "";
      var local3:Boolean = true;
      for each(local4 in param1) {
        if(!local3) {
          local2 += ", ";
        }
        local2 += local4.toString(16);
        local3 = false;
      }
      return local2;
    }

    private function getBit(param1:int) : Boolean {
      var local2:int = param1 >> 3;
      var local3:int = 7 ^ param1 & 7;
      return (this.data[local2] & 1 << local3) != 0;
    }

    private function setBit(param1:int, param2:Boolean) : void {
      var local5:int = 0;
      var local3:int = param1 >> 3;
      var local4:int = 7 ^ param1 & 7;
      if(param2) {
        this.data[local3] = int(this.data[local3] | 1 << local4);
      } else {
        local5 = int(0xFF ^ 1 << local4);
        this.data[local3] = int(this.data[local3] & local5);
      }
    }

    public function getLength() : int {
      return this.length;
    }

    public function getData() : Array {
      return this.data;
    }
  }
}
