package projects.tanks.client.garage.models.item.upgradeable.types {
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class GaragePropertyParams {
    private var _precision:int;
    private var _properties:Vector.<PropertyData>;
    private var _property:ItemGarageProperty;
    private var _visibleInInfo:Boolean;

    public function GaragePropertyParams(param1:int = 0, param2:Vector.<PropertyData> = null, param3:ItemGarageProperty = null, param4:Boolean = false) {
      super();
      this._precision = param1;
      this._properties = param2;
      this._property = param3;
      this._visibleInInfo = param4;
    }

    public function get precision() : int {
      return this._precision;
    }

    public function set precision(param1:int) : void {
      this._precision = param1;
    }

    public function get properties() : Vector.<PropertyData> {
      return this._properties;
    }

    public function set properties(param1:Vector.<PropertyData>) : void {
      this._properties = param1;
    }

    public function get property() : ItemGarageProperty {
      return this._property;
    }

    public function set property(param1:ItemGarageProperty) : void {
      this._property = param1;
    }

    public function get visibleInInfo() : Boolean {
      return this._visibleInInfo;
    }

    public function set visibleInInfo(param1:Boolean) : void {
      this._visibleInInfo = param1;
    }

    public function toString() : String {
      var local1:String = "GaragePropertyParams [";
      local1 += "precision = " + this.precision + " ";
      local1 += "properties = " + this.properties + " ";
      local1 += "property = " + this.property + " ";
      local1 += "visibleInInfo = " + this.visibleInInfo + " ";
      return local1 + "]";
    }
  }
}
