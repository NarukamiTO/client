package alternativa.tanks {
  public class AbstractEnum {
    private var _value:int;
    private var _name:String;

    public function AbstractEnum(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public function toString() : String {
      return this._name;
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
