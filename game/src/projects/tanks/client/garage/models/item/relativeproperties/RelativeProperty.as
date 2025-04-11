package projects.tanks.client.garage.models.item.relativeproperties {
  public class RelativeProperty {
    private var _property:RelativeProperties;
    private var _value:int;

    public function RelativeProperty(param1:RelativeProperties = null, param2:int = 0) {
      super();
      this._property = param1;
      this._value = param2;
    }

    public function get property() : RelativeProperties {
      return this._property;
    }

    public function set property(param1:RelativeProperties) : void {
      this._property = param1;
    }

    public function get value() : int {
      return this._value;
    }

    public function set value(param1:int) : void {
      this._value = param1;
    }

    public function toString() : String {
      var local1:String = "RelativeProperty [";
      local1 += "property = " + this.property + " ";
      local1 += "value = " + this.value + " ";
      return local1 + "]";
    }
  }
}
