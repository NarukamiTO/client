package projects.tanks.client.battlefield.models.tankparts.weapon.shot {
  public class ShotCC {
    private var _reloadMsec:int;

    public function ShotCC(param1:int = 0) {
      super();
      this._reloadMsec = param1;
    }

    public function get reloadMsec() : int {
      return this._reloadMsec;
    }

    public function set reloadMsec(param1:int) : void {
      this._reloadMsec = param1;
    }

    public function toString() : String {
      var local1:String = "ShotCC [";
      local1 += "reloadMsec = " + this.reloadMsec + " ";
      return local1 + "]";
    }
  }
}
