package projects.tanks.client.battlefield.models.battle.cp {
  public class ControlPointState {
    public static const RED:ControlPointState = new ControlPointState(0,"RED");
    public static const BLUE:ControlPointState = new ControlPointState(1,"BLUE");
    public static const NEUTRAL:ControlPointState = new ControlPointState(2,"NEUTRAL");

    private var _value:int;
    private var _name:String;

    public function ControlPointState(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ControlPointState> {
      var local1:Vector.<ControlPointState> = new Vector.<ControlPointState>();
      local1.push(RED);
      local1.push(BLUE);
      local1.push(NEUTRAL);
      return local1;
    }

    public function toString() : String {
      return "ControlPointState [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
