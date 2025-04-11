package alternativa.protocol {
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;

  public class ProtocolBuffer {
    private var _writer:IDataOutput;
    private var _reader:IDataInput;
    private var _optionalMap:OptionalMap;

    public function ProtocolBuffer(param1:IDataOutput, param2:IDataInput, param3:OptionalMap) {
      super();
      this._writer = param1;
      this._reader = param2;
      this._optionalMap = param3;
    }

    public function get writer() : IDataOutput {
      return this._writer;
    }

    public function set writer(param1:IDataOutput) : void {
      this._writer = param1;
    }

    public function get reader() : IDataInput {
      return this._reader;
    }

    public function set reader(param1:IDataInput) : void {
      this._reader = param1;
    }

    public function get optionalMap() : OptionalMap {
      return this._optionalMap;
    }

    public function set optionalMap(param1:OptionalMap) : void {
      this._optionalMap = param1;
    }

    public function toString() : String {
      var local6:int = 0;
      var local7:String = null;
      var local1:String = "";
      var local2:int = int(ByteArray(this.reader).position);
      local1 += "\n=== Optional Map ===\n";
      local1 += this.optionalMap.toString();
      local1 += "\n=== Dump data (trunc 100 bytes) ===\n";
      var local3:int = 0;
      var local4:String = "";
      var local5:int = 0;
      while(Boolean(ByteArray(this.reader).bytesAvailable) && local5 < 100) {
        local6 = int(this.reader.readByte());
        local7 = String.fromCharCode(local6);
        if(local6 >= 0 && local6 < 16) {
          local1 += "0";
        }
        if(local6 < 0) {
          local6 = 256 + local6;
        }
        local1 += local6.toString(16);
        local1 += " ";
        if(local6 < 12 && local6 > 128) {
          local4 += ".";
        } else {
          local4 += local7;
        }
        local3++;
        if(local3 > 16) {
          local1 += "\t";
          local1 += local4;
          local1 += "\n";
          local3 = 0;
          local4 = "";
        }
        local5++;
      }
      if(local3 != 0) {
        while(local3 < 18) {
          local3++;
          local1 += "   ";
        }
        local1 += "\t";
        local1 += local4;
        local1 += "\n";
      }
      ByteArray(this.reader).position = local2;
      return local1;
    }
  }
}
