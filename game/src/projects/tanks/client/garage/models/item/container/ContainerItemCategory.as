package projects.tanks.client.garage.models.item.container {
  public class ContainerItemCategory {
    public static const COMMON:ContainerItemCategory = new ContainerItemCategory(0,"COMMON");
    public static const UNCOMMON:ContainerItemCategory = new ContainerItemCategory(1,"UNCOMMON");
    public static const RARE:ContainerItemCategory = new ContainerItemCategory(2,"RARE");
    public static const EPIC:ContainerItemCategory = new ContainerItemCategory(3,"EPIC");
    public static const LEGENDARY:ContainerItemCategory = new ContainerItemCategory(4,"LEGENDARY");
    public static const EXOTIC:ContainerItemCategory = new ContainerItemCategory(5,"EXOTIC");

    private var _value:int;
    private var _name:String;

    public function ContainerItemCategory(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ContainerItemCategory> {
      var local1:Vector.<ContainerItemCategory> = new Vector.<ContainerItemCategory>();
      local1.push(COMMON);
      local1.push(UNCOMMON);
      local1.push(RARE);
      local1.push(EPIC);
      local1.push(LEGENDARY);
      local1.push(EXOTIC);
      return local1;
    }

    public function toString() : String {
      return "ContainerItemCategory [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
