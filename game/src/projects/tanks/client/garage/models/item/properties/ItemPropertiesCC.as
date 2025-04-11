package projects.tanks.client.garage.models.item.properties {
  public class ItemPropertiesCC {
    private var _properties:Vector.<ItemGaragePropertyData>;

    public function ItemPropertiesCC(param1:Vector.<ItemGaragePropertyData> = null) {
      super();
      this._properties = param1;
    }

    public function get properties() : Vector.<ItemGaragePropertyData> {
      return this._properties;
    }

    public function set properties(param1:Vector.<ItemGaragePropertyData>) : void {
      this._properties = param1;
    }

    public function toString() : String {
      var local1:String = "ItemPropertiesCC [";
      local1 += "properties = " + this.properties + " ";
      return local1 + "]";
    }
  }
}
