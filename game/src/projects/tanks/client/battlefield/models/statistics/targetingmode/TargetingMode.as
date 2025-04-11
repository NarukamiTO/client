package projects.tanks.client.battlefield.models.statistics.targetingmode {
  public class TargetingMode {
    public static const NONE:TargetingMode = new TargetingMode(0,"NONE");
    public static const KEYBOARD:TargetingMode = new TargetingMode(1,"KEYBOARD");
    public static const MOUSE_LOOK:TargetingMode = new TargetingMode(2,"MOUSE_LOOK");

    private var _value:int;
    private var _name:String;

    public function TargetingMode(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<TargetingMode> {
      var local1:Vector.<TargetingMode> = new Vector.<TargetingMode>();
      local1.push(NONE);
      local1.push(KEYBOARD);
      local1.push(MOUSE_LOOK);
      return local1;
    }

    public function toString() : String {
      return "TargetingMode [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
