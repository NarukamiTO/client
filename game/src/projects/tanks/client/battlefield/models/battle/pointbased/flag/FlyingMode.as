package projects.tanks.client.battlefield.models.battle.pointbased.flag {
  public class FlyingMode {
    public static const FLY:FlyingMode = new FlyingMode(0,"FLY");
    public static const ROLL:FlyingMode = new FlyingMode(1,"ROLL");
    public static const IMPACT:FlyingMode = new FlyingMode(2,"IMPACT");
    public static const DROP:FlyingMode = new FlyingMode(3,"DROP");
    public static const KILL:FlyingMode = new FlyingMode(4,"KILL");

    private var _value:int;
    private var _name:String;

    public function FlyingMode(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<FlyingMode> {
      var local1:Vector.<FlyingMode> = new Vector.<FlyingMode>();
      local1.push(FLY);
      local1.push(ROLL);
      local1.push(IMPACT);
      local1.push(DROP);
      local1.push(KILL);
      return local1;
    }

    public function toString() : String {
      return "FlyingMode [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
