package projects.tanks.client.panel.model.donationalert.types {
  public class GoodInfoData {
    private var _count:int;
    private var _name:String;

    public function GoodInfoData(param1:int = 0, param2:String = null) {
      super();
      this._count = param1;
      this._name = param2;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "GoodInfoData [";
      local1 += "count = " + this.count + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
