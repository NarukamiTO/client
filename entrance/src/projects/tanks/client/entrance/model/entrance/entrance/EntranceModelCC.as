package projects.tanks.client.entrance.model.entrance.entrance {
  public class EntranceModelCC {
    private var _antiAddictionEnabled:Boolean;

    public function EntranceModelCC(param1:Boolean = false) {
      super();
      this._antiAddictionEnabled = param1;
    }

    public function get antiAddictionEnabled() : Boolean {
      return this._antiAddictionEnabled;
    }

    public function set antiAddictionEnabled(param1:Boolean) : void {
      this._antiAddictionEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "EntranceModelCC [";
      local1 += "antiAddictionEnabled = " + this.antiAddictionEnabled + " ";
      return local1 + "]";
    }
  }
}
