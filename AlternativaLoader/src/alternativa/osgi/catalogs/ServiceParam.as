package alternativa.osgi.catalogs {
  public class ServiceParam {
    private var _name:String;
    private var _value:*;

    public function ServiceParam(param1:String, param2:*) {
      super();
      this._name = param1;
      this._value = param2;
    }

    public function get name() : String {
      return this._name;
    }

    public function get value() : * {
      return this._value;
    }
  }
}
