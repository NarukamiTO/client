package projects.tanks.client.battlefield.types {
  public class DamageType {
    public static const SMOKY:DamageType = new DamageType(0,"SMOKY");
    public static const SMOKY_CRITICAL:DamageType = new DamageType(1,"SMOKY_CRITICAL");
    public static const FIREBIRD:DamageType = new DamageType(2,"FIREBIRD");
    public static const FIREBIRD_OVERHEAT:DamageType = new DamageType(3,"FIREBIRD_OVERHEAT");
    public static const TWINS:DamageType = new DamageType(4,"TWINS");
    public static const RAILGUN:DamageType = new DamageType(5,"RAILGUN");
    public static const ISIS:DamageType = new DamageType(6,"ISIS");
    public static const MINE:DamageType = new DamageType(7,"MINE");
    public static const THUNDER:DamageType = new DamageType(8,"THUNDER");
    public static const RICOCHET:DamageType = new DamageType(9,"RICOCHET");
    public static const FREEZE:DamageType = new DamageType(10,"FREEZE");
    public static const SHAFT:DamageType = new DamageType(11,"SHAFT");
    public static const MACHINE_GUN:DamageType = new DamageType(12,"MACHINE_GUN");
    public static const SHOTGUN:DamageType = new DamageType(13,"SHOTGUN");
    public static const ROCKET:DamageType = new DamageType(14,"ROCKET");
    public static const ARTILLERY:DamageType = new DamageType(15,"ARTILLERY");
    public static const TERMINATOR:DamageType = new DamageType(16,"TERMINATOR");
    public static const BOMB:DamageType = new DamageType(17,"BOMB");
    public static const AT_FIELD:DamageType = new DamageType(18,"AT_FIELD");
    public static const NUCLEAR:DamageType = new DamageType(19,"NUCLEAR");
    public static const GAUSS:DamageType = new DamageType(20,"GAUSS");

    private var _value:int;
    private var _name:String;

    public function DamageType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<DamageType> {
      var local1:Vector.<DamageType> = new Vector.<DamageType>();
      local1.push(SMOKY);
      local1.push(SMOKY_CRITICAL);
      local1.push(FIREBIRD);
      local1.push(FIREBIRD_OVERHEAT);
      local1.push(TWINS);
      local1.push(RAILGUN);
      local1.push(ISIS);
      local1.push(MINE);
      local1.push(THUNDER);
      local1.push(RICOCHET);
      local1.push(FREEZE);
      local1.push(SHAFT);
      local1.push(MACHINE_GUN);
      local1.push(SHOTGUN);
      local1.push(ROCKET);
      local1.push(ARTILLERY);
      local1.push(TERMINATOR);
      local1.push(BOMB);
      local1.push(AT_FIELD);
      local1.push(NUCLEAR);
      local1.push(GAUSS);
      return local1;
    }

    public function toString() : String {
      return "DamageType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
