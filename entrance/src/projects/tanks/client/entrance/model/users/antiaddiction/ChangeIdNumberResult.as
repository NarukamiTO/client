package projects.tanks.client.entrance.model.users.antiaddiction {
  public class ChangeIdNumberResult {
    public static const OK:ChangeIdNumberResult = new ChangeIdNumberResult(0,"OK");
    public static const ID_IS_ALREADY_CORRECT:ChangeIdNumberResult = new ChangeIdNumberResult(1,"ID_IS_ALREADY_CORRECT");
    public static const ID_IS_INCORRECT:ChangeIdNumberResult = new ChangeIdNumberResult(2,"ID_IS_INCORRECT");
    public static const NAME_IS_INCORRECT:ChangeIdNumberResult = new ChangeIdNumberResult(3,"NAME_IS_INCORRECT");

    private var _value:int;
    private var _name:String;

    public function ChangeIdNumberResult(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ChangeIdNumberResult> {
      var local1:Vector.<ChangeIdNumberResult> = new Vector.<ChangeIdNumberResult>();
      local1.push(OK);
      local1.push(ID_IS_ALREADY_CORRECT);
      local1.push(ID_IS_INCORRECT);
      local1.push(NAME_IS_INCORRECT);
      return local1;
    }

    public function toString() : String {
      return "ChangeIdNumberResult [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
