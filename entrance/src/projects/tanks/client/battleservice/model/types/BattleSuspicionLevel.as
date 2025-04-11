package projects.tanks.client.battleservice.model.types {
  public class BattleSuspicionLevel {
    public static const NONE:BattleSuspicionLevel = new BattleSuspicionLevel(0,"NONE");
    public static const LOW:BattleSuspicionLevel = new BattleSuspicionLevel(1,"LOW");
    public static const HIGH:BattleSuspicionLevel = new BattleSuspicionLevel(2,"HIGH");

    private var _value:int;
    private var _name:String;

    public function BattleSuspicionLevel(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<BattleSuspicionLevel> {
      var local1:Vector.<BattleSuspicionLevel> = new Vector.<BattleSuspicionLevel>();
      local1.push(NONE);
      local1.push(LOW);
      local1.push(HIGH);
      return local1;
    }

    public function toString() : String {
      return "BattleSuspicionLevel [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
