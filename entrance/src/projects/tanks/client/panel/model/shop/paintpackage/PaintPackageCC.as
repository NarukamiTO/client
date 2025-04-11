package projects.tanks.client.panel.model.shop.paintpackage {
  public class PaintPackageCC {
    private var _description:String;
    private var _name:String;

    public function PaintPackageCC(param1:String = null, param2:String = null) {
      super();
      this._description = param1;
      this._name = param2;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "PaintPackageCC [";
      local1 += "description = " + this.description + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
