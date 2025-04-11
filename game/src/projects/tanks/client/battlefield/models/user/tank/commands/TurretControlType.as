package projects.tanks.client.battlefield.models.user.tank.commands {
  public class TurretControlType {
    public static const ROTATION_DIRECTION:TurretControlType = new TurretControlType(0,"ROTATION_DIRECTION");
    public static const TARGET_ANGLE_LOCAL:TurretControlType = new TurretControlType(1,"TARGET_ANGLE_LOCAL");
    public static const TARGET_ANGLE_WORLD:TurretControlType = new TurretControlType(2,"TARGET_ANGLE_WORLD");

    private var _value:int;
    private var _name:String;

    public function TurretControlType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<TurretControlType> {
      var local1:Vector.<TurretControlType> = new Vector.<TurretControlType>();
      local1.push(ROTATION_DIRECTION);
      local1.push(TARGET_ANGLE_LOCAL);
      local1.push(TARGET_ANGLE_WORLD);
      return local1;
    }

    public function toString() : String {
      return "TurretControlType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
