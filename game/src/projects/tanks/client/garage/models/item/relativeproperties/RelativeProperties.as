package projects.tanks.client.garage.models.item.relativeproperties {
  public class RelativeProperties {
    public static const ARMOR:RelativeProperties = new RelativeProperties(0,"ARMOR");
    public static const SPEED:RelativeProperties = new RelativeProperties(1,"SPEED");
    public static const HANDLING:RelativeProperties = new RelativeProperties(2,"HANDLING");
    public static const MASS:RelativeProperties = new RelativeProperties(3,"MASS");
    public static const SIZE:RelativeProperties = new RelativeProperties(4,"SIZE");
    public static const BURST_DAMAGE:RelativeProperties = new RelativeProperties(5,"BURST_DAMAGE");
    public static const DPS:RelativeProperties = new RelativeProperties(6,"DPS");
    public static const FIRE_RATE:RelativeProperties = new RelativeProperties(7,"FIRE_RATE");
    public static const RANGE:RelativeProperties = new RelativeProperties(8,"RANGE");
    public static const COMPLEXITY:RelativeProperties = new RelativeProperties(9,"COMPLEXITY");

    private var _value:int;
    private var _name:String;

    public function RelativeProperties(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<RelativeProperties> {
      var local1:Vector.<RelativeProperties> = new Vector.<RelativeProperties>();
      local1.push(ARMOR);
      local1.push(SPEED);
      local1.push(HANDLING);
      local1.push(MASS);
      local1.push(SIZE);
      local1.push(BURST_DAMAGE);
      local1.push(DPS);
      local1.push(FIRE_RATE);
      local1.push(RANGE);
      local1.push(COMPLEXITY);
      return local1;
    }

    public function toString() : String {
      return "RelativeProperties [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
