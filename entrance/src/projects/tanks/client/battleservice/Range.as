package projects.tanks.client.battleservice {
  public class Range {
    private var _max:int;
    private var _min:int;

    public function Range(param1:int = 0, param2:int = 0) {
      super();
      this._max = param1;
      this._min = param2;
    }

    public function get max() : int {
      return this._max;
    }

    public function set max(param1:int) : void {
      this._max = param1;
    }

    public function get min() : int {
      return this._min;
    }

    public function set min(param1:int) : void {
      this._min = param1;
    }

    public function toString() : String {
      var local1:String = "Range [";
      local1 += "max = " + this.max + " ";
      local1 += "min = " + this.min + " ";
      return local1 + "]";
    }
  }
}
