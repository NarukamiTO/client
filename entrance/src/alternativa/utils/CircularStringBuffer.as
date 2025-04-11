package alternativa.utils {
  public class CircularStringBuffer implements ICircularStringBuffer {
    public var strings:Vector.<String>;
    public var headIndex:int;
    public var tailIndex:int;

    private var _capacity:int;

    public function CircularStringBuffer(param1:int) {
      super();
      this._capacity = param1;
      this.strings = new Vector.<String>(this._capacity + 1);
    }

    public function add(param1:String) : void {
      this.strings[this.tailIndex] = param1;
      this.tailIndex = this.incIndex(this.tailIndex);
      if(this.tailIndex == this.headIndex) {
        this.headIndex = this.incIndex(this.headIndex);
      }
    }

    public function clear() : void {
      this.headIndex = 0;
      this.tailIndex = 0;
      var local1:int = int(this.strings.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.strings[local2] = null;
        local2++;
      }
    }

    public function get size() : int {
      var local1:int = this.tailIndex - this.headIndex;
      if(local1 < 0) {
        local1 += this.strings.length;
      }
      return local1;
    }

    public function get capacity() : int {
      return this._capacity;
    }

    public function getStrings() : Vector.<String> {
      var local1:Vector.<String> = new Vector.<String>();
      var local2:int = this.headIndex;
      while(local2 != this.tailIndex) {
        local1.push(this.strings[local2]);
        local2 = this.incIndex(local2);
      }
      return local1;
    }

    public function set capacity(param1:int) : void {
      throw new Error("Unimplemented");
    }

    public function getIterator(param1:int) : IStringBufferIterator {
      return new Iterator(this,param1);
    }

    private function incIndex(param1:int) : int {
      return ++param1 >= this.strings.length ? 0 : param1;
    }
  }
}

class Iterator implements IStringBufferIterator {
  private var buffer:CircularStringBuffer;
  private var index:int;

  public function Iterator(param1:CircularStringBuffer, param2:int) {
    super();
    if(param2 < 0 || param2 > param1.size) {
      throw new Error("Index " + param2 + " is out of range [0, " + param1.size + "]");
    }
    this.buffer = param1;
    var local3:uint = param1.strings.length;
    this.index = param1.headIndex + param2 - 1;
    if(this.index < 0) {
      this.index = local3 - 1;
    }
    if(this.index >= local3) {
      this.index -= local3;
    }
  }

  public function hasNext() : Boolean {
    return this.incIndex(this.index) != this.buffer.tailIndex;
  }

  public function getNext() : String {
    this.index = this.incIndex(this.index);
    if(this.index == this.buffer.tailIndex) {
      throw new Error("End of buffer");
    }
    return this.buffer.strings[this.index];
  }

  private function incIndex(param1:int) : int {
    return ++param1 >= this.buffer.strings.length ? 0 : param1;
  }
}
