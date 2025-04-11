package projects.tanks.client.tanksservices.model.rankloader {
  public class RankInfo {
    private var _index:int;
    private var _name:String;

    public function RankInfo(param1:int = 0, param2:String = null) {
      super();
      this._index = param1;
      this._name = param2;
    }

    public function get index() : int {
      return this._index;
    }

    public function set index(param1:int) : void {
      this._index = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "RankInfo [";
      local1 += "index = " + this.index + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
