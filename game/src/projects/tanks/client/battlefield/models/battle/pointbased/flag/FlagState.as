package projects.tanks.client.battlefield.models.battle.pointbased.flag {
  public class FlagState {
    public static const AT_BASE:FlagState = new FlagState(0,"AT_BASE");
    public static const DROPPED:FlagState = new FlagState(1,"DROPPED");
    public static const CARRIED:FlagState = new FlagState(2,"CARRIED");
    public static const EXILED:FlagState = new FlagState(3,"EXILED");
    public static const FLYING:FlagState = new FlagState(4,"FLYING");

    private var _value:int;
    private var _name:String;

    public function FlagState(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<FlagState> {
      var local1:Vector.<FlagState> = new Vector.<FlagState>();
      local1.push(AT_BASE);
      local1.push(DROPPED);
      local1.push(CARRIED);
      local1.push(EXILED);
      local1.push(FLYING);
      return local1;
    }

    public function toString() : String {
      return "FlagState [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
