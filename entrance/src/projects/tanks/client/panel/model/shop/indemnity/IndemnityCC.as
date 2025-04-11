package projects.tanks.client.panel.model.shop.indemnity {
  public class IndemnityCC {
    private var _indemnitySize:int;

    public function IndemnityCC(param1:int = 0) {
      super();
      this._indemnitySize = param1;
    }

    public function get indemnitySize() : int {
      return this._indemnitySize;
    }

    public function set indemnitySize(param1:int) : void {
      this._indemnitySize = param1;
    }

    public function toString() : String {
      var local1:String = "IndemnityCC [";
      local1 += "indemnitySize = " + this.indemnitySize + " ";
      return local1 + "]";
    }
  }
}
