package platform.client.fp10.core.resource.tara {
  import flash.utils.ByteArray;

  public class TARAParser {
    private var _data:Object;

    public function TARAParser(param1:ByteArray) {
      super();
      if(param1 != null) {
        this.parse(param1);
      }
    }

    public function parse(param1:ByteArray) : void {
      var local4:int = 0;
      var local5:ByteArray = null;
      var local6:FileInfo = null;
      var local2:int = param1.readInt();
      var local3:Vector.<FileInfo> = new Vector.<FileInfo>(local2);
      local4 = 0;
      while(local4 < local2) {
        local3[local4] = new FileInfo(param1.readUTF(),param1.readInt());
        local4++;
      }
      this._data = {};
      local4 = 0;
      while(local4 < local2) {
        local5 = new ByteArray();
        local6 = local3[local4];
        param1.readBytes(local5,0,local6.size);
        this._data[local6.name] = local5;
        local4++;
      }
    }

    public function get data() : Object {
      return this._data;
    }

    public function getFileData(param1:String) : ByteArray {
      if(this._data == null) {
        return null;
      }
      return ByteArray(this._data[param1]);
    }
  }
}

class FileInfo {
  public var name:String;
  public var size:int;

  public function FileInfo(param1:String, param2:int) {
    super();
    this.name = param1;
    this.size = param2;
  }
}
