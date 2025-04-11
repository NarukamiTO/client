package projects.tanks.client.garage.models.item.grouped {
  public class GroupedCC {
    private var _group:int;
    private var _grouped:Boolean;

    public function GroupedCC(param1:int = 0, param2:Boolean = false) {
      super();
      this._group = param1;
      this._grouped = param2;
    }

    public function get group() : int {
      return this._group;
    }

    public function set group(param1:int) : void {
      this._group = param1;
    }

    public function get grouped() : Boolean {
      return this._grouped;
    }

    public function set grouped(param1:Boolean) : void {
      this._grouped = param1;
    }

    public function toString() : String {
      var local1:String = "GroupedCC [";
      local1 += "group = " + this.group + " ";
      local1 += "grouped = " + this.grouped + " ";
      return local1 + "]";
    }
  }
}
