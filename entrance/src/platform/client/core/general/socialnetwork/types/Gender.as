package platform.client.core.general.socialnetwork.types {
  public class Gender {
    public static const MALE:Gender = new Gender(0,"MALE");
    public static const FEMALE:Gender = new Gender(1,"FEMALE");
    public static const NONE:Gender = new Gender(2,"NONE");

    private var _value:int;
    private var _name:String;

    public function Gender(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<Gender> {
      var local1:Vector.<Gender> = new Vector.<Gender>();
      local1.push(MALE);
      local1.push(FEMALE);
      local1.push(NONE);
      return local1;
    }

    public function toString() : String {
      return "Gender [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
