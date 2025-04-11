package projects.tanks.client.garage.models.item.upgradeable.types {
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class PropertyData {
    private var _finalValue:Number;
    private var _initialValue:Number;
    private var _property:ItemProperty;

    public function PropertyData(param1:Number = 0, param2:Number = 0, param3:ItemProperty = null) {
      super();
      this._finalValue = param1;
      this._initialValue = param2;
      this._property = param3;
    }

    public function get finalValue() : Number {
      return this._finalValue;
    }

    public function set finalValue(param1:Number) : void {
      this._finalValue = param1;
    }

    public function get initialValue() : Number {
      return this._initialValue;
    }

    public function set initialValue(param1:Number) : void {
      this._initialValue = param1;
    }

    public function get property() : ItemProperty {
      return this._property;
    }

    public function set property(param1:ItemProperty) : void {
      this._property = param1;
    }

    public function toString() : String {
      var local1:String = "PropertyData [";
      local1 += "finalValue = " + this.finalValue + " ";
      local1 += "initialValue = " + this.initialValue + " ";
      local1 += "property = " + this.property + " ";
      return local1 + "]";
    }
  }
}
