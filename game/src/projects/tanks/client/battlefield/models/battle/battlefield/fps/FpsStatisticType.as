package projects.tanks.client.battlefield.models.battle.battlefield.fps {
  public class FpsStatisticType {
    public static const SOFTWARE:FpsStatisticType = new FpsStatisticType(0,"SOFTWARE");
    public static const HARDWARE_CONSTRAINT:FpsStatisticType = new FpsStatisticType(1,"HARDWARE_CONSTRAINT");
    public static const HARDWARE_BASELINE:FpsStatisticType = new FpsStatisticType(2,"HARDWARE_BASELINE");

    private var _value:int;
    private var _name:String;

    public function FpsStatisticType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<FpsStatisticType> {
      var local1:Vector.<FpsStatisticType> = new Vector.<FpsStatisticType>();
      local1.push(SOFTWARE);
      local1.push(HARDWARE_CONSTRAINT);
      local1.push(HARDWARE_BASELINE);
      return local1;
    }

    public function toString() : String {
      return "FpsStatisticType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
