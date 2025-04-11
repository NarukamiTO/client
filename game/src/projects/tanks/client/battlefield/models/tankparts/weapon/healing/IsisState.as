package projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  public class IsisState {
    public static const OFF:IsisState = new IsisState(0,"OFF");
    public static const IDLE:IsisState = new IsisState(1,"IDLE");
    public static const HEALING:IsisState = new IsisState(2,"HEALING");
    public static const DAMAGING:IsisState = new IsisState(3,"DAMAGING");

    private var _value:int;
    private var _name:String;

    public function IsisState(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<IsisState> {
      var local1:Vector.<IsisState> = new Vector.<IsisState>();
      local1.push(OFF);
      local1.push(IDLE);
      local1.push(HEALING);
      local1.push(DAMAGING);
      return local1;
    }

    public function toString() : String {
      return "IsisState [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
