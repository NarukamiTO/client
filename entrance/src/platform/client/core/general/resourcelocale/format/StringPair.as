package platform.client.core.general.resourcelocale.format {
  public class StringPair {
    private var _key:String;
    private var _value:String;

    public function StringPair(param1:String = null, param2:String = null) {
      super();
      this._key = param1;
      this._value = param2;
    }

    public function get key() : String {
      return this._key;
    }

    public function set key(param1:String) : void {
      this._key = param1;
    }

    public function get value() : String {
      return this._value;
    }

    public function set value(param1:String) : void {
      this._value = param1;
    }

    public function toString() : String {
      var local1:String = "StringPair [";
      local1 += "key = " + this.key + " ";
      local1 += "value = " + this.value + " ";
      return local1 + "]";
    }
  }
}
