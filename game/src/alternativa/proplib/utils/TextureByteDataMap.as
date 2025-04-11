package alternativa.proplib.utils {
  import alternativa.utils.textureutils.TextureByteData;

  public class TextureByteDataMap {
    private var _data:Object;

    public function TextureByteDataMap(data:Object = null) {
      super();
      this._data = data == null ? {} : data;
    }

    public function get data() : Object {
      return this._data;
    }

    public function getValue(key:String) : TextureByteData {
      return this._data[key];
    }

    public function putValue(key:String, value:TextureByteData) : void {
      this._data[key] = value;
    }
  }
}
