package alternativa.proplib.utils {
  import flash.utils.ByteArray;

  public class ByteArrayMap {
    private var _data:Object;

    public function ByteArrayMap(data:Object = null) {
      super();
      this._data = data == null ? {} : data;
    }

    public function get data() : Object {
      return this._data;
    }

    public function getValue(key:String) : ByteArray {
      return this._data[key];
    }

    public function putValue(key:String, value:ByteArray) : void {
      this._data[key] = value;
    }
  }
}
