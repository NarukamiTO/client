package projects.tanks.client.tanksservices.model.formatbattle {
  public class EquipmentConstraintsModeInfo {
    private var _index:int;
    private var _mode:String;
    private var _name:String;

    public function EquipmentConstraintsModeInfo(param1:int = 0, param2:String = null, param3:String = null) {
      super();
      this._index = param1;
      this._mode = param2;
      this._name = param3;
    }

    public function get index() : int {
      return this._index;
    }

    public function set index(param1:int) : void {
      this._index = param1;
    }

    public function get mode() : String {
      return this._mode;
    }

    public function set mode(param1:String) : void {
      this._mode = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "EquipmentConstraintsModeInfo [";
      local1 += "index = " + this.index + " ";
      local1 += "mode = " + this.mode + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
