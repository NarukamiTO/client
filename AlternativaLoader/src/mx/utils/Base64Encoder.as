package mx.utils {
  import flash.utils.ByteArray;

  public class Base64Encoder {
    public static const CHARSET_UTF_8:String = "UTF-8";

    public static var newLine:int = 10;

    public static const MAX_BUFFER_SIZE:uint = 32767;

    private static const ESCAPE_CHAR_CODE:Number = 61;
    private static const ALPHABET_CHAR_CODES:Array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,54,55,56,57,43,47];

    public var insertNewLines:Boolean = true;

    private var _buffers:Array;
    private var _count:uint;
    private var _line:uint;
    private var _work:Array = [0,0,0];

    public function Base64Encoder() {
      super();
      this.reset();
    }

    public function drain() : String {
      var local3:Array = null;
      var local1:String = "";
      var local2:uint = 0;
      while(local2 < this._buffers.length) {
        local3 = this._buffers[local2] as Array;
        local1 += String.fromCharCode.apply(null,local3);
        local2++;
      }
      this._buffers = [];
      this._buffers.push([]);
      return local1;
    }

    public function encode(param1:String, param2:uint = 0, param3:uint = 0) : void {
      if(param3 == 0) {
        param3 = uint(param1.length);
      }
      var local4:uint = param2;
      var local5:uint = param2 + param3;
      if(local5 > param1.length) {
        local5 = uint(param1.length);
      }
      while(local4 < local5) {
        this._work[this._count] = param1.charCodeAt(local4);
        ++this._count;
        if(this._count == this._work.length || local5 - local4 == 1) {
          this.encodeBlock();
          this._count = 0;
          this._work[0] = 0;
          this._work[1] = 0;
          this._work[2] = 0;
        }
        local4++;
      }
    }

    public function encodeUTFBytes(param1:String) : void {
      var local2:ByteArray = new ByteArray();
      local2.writeUTFBytes(param1);
      local2.position = 0;
      this.encodeBytes(local2);
    }

    public function encodeBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void {
      if(param3 == 0) {
        param3 = param1.length;
      }
      var local4:uint = param1.position;
      param1.position = param2;
      var local5:uint = param2;
      var local6:uint = param2 + param3;
      if(local6 > param1.length) {
        local6 = param1.length;
      }
      while(local5 < local6) {
        this._work[this._count] = param1[local5];
        ++this._count;
        if(this._count == this._work.length || local6 - local5 == 1) {
          this.encodeBlock();
          this._count = 0;
          this._work[0] = 0;
          this._work[1] = 0;
          this._work[2] = 0;
        }
        local5++;
      }
      param1.position = local4;
    }

    public function flush() : String {
      if(this._count > 0) {
        this.encodeBlock();
      }
      var local1:String = this.drain();
      this.reset();
      return local1;
    }

    public function reset() : void {
      this._buffers = [];
      this._buffers.push([]);
      this._count = 0;
      this._line = 0;
      this._work[0] = 0;
      this._work[1] = 0;
      this._work[2] = 0;
    }

    public function toString() : String {
      return this.flush();
    }

    private function encodeBlock() : void {
      var local1:Array = this._buffers[this._buffers.length - 1] as Array;
      if(local1.length >= MAX_BUFFER_SIZE) {
        local1 = [];
        this._buffers.push(local1);
      }
      local1.push(ALPHABET_CHAR_CODES[(this._work[0] & 0xFF) >> 2]);
      local1.push(ALPHABET_CHAR_CODES[(this._work[0] & 3) << 4 | (this._work[1] & 0xF0) >> 4]);
      if(this._count > 1) {
        local1.push(ALPHABET_CHAR_CODES[(this._work[1] & 0x0F) << 2 | (this._work[2] & 0xC0) >> 6]);
      } else {
        local1.push(ESCAPE_CHAR_CODE);
      }
      if(this._count > 2) {
        local1.push(ALPHABET_CHAR_CODES[this._work[2] & 0x3F]);
      } else {
        local1.push(ESCAPE_CHAR_CODE);
      }
      if(this.insertNewLines) {
        if((this._line = this._line + 4) == 76) {
          local1.push(newLine);
          this._line = 0;
        }
      }
    }
  }
}
