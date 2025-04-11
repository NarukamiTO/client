package projects.tanks.client.battleservice.model.map.params {
  public class MapTheme {
    public static const SUMMER:MapTheme = new MapTheme(0,"SUMMER");
    public static const WINTER:MapTheme = new MapTheme(1,"WINTER");
    public static const DAY:MapTheme = new MapTheme(2,"DAY");
    public static const NIGHT:MapTheme = new MapTheme(3,"NIGHT");
    public static const SUMMER_DAY:MapTheme = new MapTheme(4,"SUMMER_DAY");
    public static const SUMMER_NIGHT:MapTheme = new MapTheme(5,"SUMMER_NIGHT");
    public static const WINTER_DAY:MapTheme = new MapTheme(6,"WINTER_DAY");
    public static const WINTER_NIGHT:MapTheme = new MapTheme(7,"WINTER_NIGHT");
    public static const SPACE:MapTheme = new MapTheme(8,"SPACE");

    private var _value:int;
    private var _name:String;

    public function MapTheme(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<MapTheme> {
      var local1:Vector.<MapTheme> = new Vector.<MapTheme>();
      local1.push(SUMMER);
      local1.push(WINTER);
      local1.push(DAY);
      local1.push(NIGHT);
      local1.push(SUMMER_DAY);
      local1.push(SUMMER_NIGHT);
      local1.push(WINTER_DAY);
      local1.push(WINTER_NIGHT);
      local1.push(SPACE);
      return local1;
    }

    public function toString() : String {
      return "MapTheme [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
