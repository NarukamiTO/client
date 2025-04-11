package projects.tanks.client.tanksservices.model.uidcheck {
  public class UidCheckCC {
    private var _length:int;

    public function UidCheckCC(param1:int = 0) {
      super();
      this._length = param1;
    }

    public function get length() : int {
      return this._length;
    }

    public function set length(param1:int) : void {
      this._length = param1;
    }

    public function toString() : String {
      var local1:String = "UidCheckCC [";
      local1 += "length = " + this.length + " ";
      return local1 + "]";
    }
  }
}
