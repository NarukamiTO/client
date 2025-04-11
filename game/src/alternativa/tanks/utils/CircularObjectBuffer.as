package alternativa.tanks.utils {
  public class CircularObjectBuffer {
    private var buffer:Vector.<Object>;
    private var writeIndex:int;
    private var headIndex:int;

    public function CircularObjectBuffer(param1:int) {
      super();
      this.buffer = new Vector.<Object>(param1 + 1,true);
    }

    public function addObject(param1:Object) : void {
      this.buffer[this.writeIndex] = param1;
      this.writeIndex = this.incIndex(this.writeIndex);
      if(this.headIndex == this.writeIndex) {
        this.headIndex = this.incIndex(this.headIndex);
      }
    }

    public function clear() : void {
      var local1:int = int(this.buffer.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.buffer[local2] = null;
        local2++;
      }
      this.headIndex = this.writeIndex = 0;
    }

    public function getObjects() : Vector.<Object> {
      var local4:int = 0;
      var local5:int = 0;
      var local1:int = this.writeIndex - this.headIndex;
      if(local1 < 0) {
        local1 += this.buffer.length;
      }
      var local2:Vector.<Object> = new Vector.<Object>(local1);
      var local3:int = int(this.buffer.length);
      local4 = 0;
      local5 = this.headIndex;
      while(local4 < local1) {
        if(local5 == local3) {
          local5 = 0;
        }
        local2[local4] = this.buffer[local5];
        local4++;
        local5++;
      }
      return local2;
    }

    private function incIndex(param1:int) : int {
      return ++param1 == this.buffer.length ? 0 : param1;
    }
  }
}
